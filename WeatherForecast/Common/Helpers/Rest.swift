import Foundation

protocol JSONValue { }
protocol JSONRoot { }
extension String: JSONValue { }
extension Int: JSONValue { }
extension Double: JSONValue { }
extension Bool: JSONValue { }
extension Optional: JSONValue { typealias Wrapped = JSONValue }
extension Array: JSONValue, JSONRoot { typealias Element = JSONValue }
extension Dictionary: JSONValue, JSONRoot { typealias Key = String; typealias Value = JSONValue }

typealias JSONSwiftObject = [String:JSONValue]
typealias JSONObject = [String:Any]
typealias JSONResult = Result<JSONObject>

protocol JSONValidation {
    static func validJson(from data: Data?, needToValidateJson: Bool) throws -> JSONObject
}

class Rest {
  enum HTTPMethod: String {
    case put = "PUT"
    case get = "GET"
    case post = "POST"
  }

  internal class func connect(method: String,
                              path: String,
                              query: String? = nil,
                              redirects: Bool? = true,
                              headers: [String:String]? = nil,
                              jsonObject: JSONObject? = nil,
                              captureResponseHeaders: Bool = false,
                              useVersion: Bool = true,
                              needToValidateJson: Bool = false,
                              completion: @escaping (JSONResult) -> Void) throws {

    guard let url = URL(string: path) else {
      throw ValidationError.invalid("path", "Invalid Path")
    }
    
    try connect(method: method, url: url, query: query, redirects: redirects, headers: headers, jsonObject: jsonObject, captureResponseHeaders: captureResponseHeaders, needToValidateJson: needToValidateJson, completion: completion)
  }
  
  internal class func connect(method: String,
                              url: URL,
                              query: String? = nil,
                              redirects: Bool? = true,
                              headers: [String:String]? = nil,
                              jsonObject: JSONObject? = nil,
                              captureResponseHeaders: Bool = false,
                              needToValidateJson: Bool = false,
                              completion: @escaping (JSONResult) -> Void) throws {
    // Setup Request
    guard var components = URLComponents(string: "\(url)") else {
        throw ValidationError.invalid("baseURL", url)
    }
    if let validQuery = query, !validQuery.isEmpty {
        components.query = validQuery
    }
    guard let url = components.url else {
        throw ValidationError.invalid("path", components.path)
    }
    
    // Setup Request
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
    request.httpMethod = method
    request.allHTTPHeaderFields = headers
    request.timeoutInterval = 5000.00
    // Setup JSON
    if let jsonObject = jsonObject {
        guard JSONSerialization.isValidJSONObject(jsonObject) else {
            print("Invalid JSON Object received: \(jsonObject)")
            throw ValidationError.invalid("jsonObject", jsonObject)
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: jsonObject,
                                                  options: [])
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.httpBody = jsonData
    }

    request.prettyPrint()

    URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
        DispatchQueue.main.async {
            response?.nicePrint(data: data, error: error, for: request)
            do {
                if let responseError = error { throw responseError }
                
                var jsonObject = try validJson(from: data, needToValidateJson: needToValidateJson)
                if captureResponseHeaders, let httpResponse = response as? HTTPURLResponse {
                    jsonObject["responseHeaders"] = httpResponse.allHeaderFields
                }
                completion(JSONResult.success(result: jsonObject))
                
            } catch let theError {
                let error = theError as NSError
                print("Rest Error: \(error.localizedDescription)")
                completion(JSONResult.failure(error: theError))
            }
        }
        
    }).resume()

  }

  // MARK: - Public methods

  class func get(path: String, query: String? = nil, headers: [String:String]? = nil,
                 captureResponseHeaders: Bool = false, useVersion: Bool = true, needToValidateJson: Bool = true,
                 completion:@escaping (JSONResult) -> Void) {
    do {
      try connect(method: HTTPMethod.get.rawValue, path: path, query: query, redirects: false, headers: headers, jsonObject: nil, captureResponseHeaders: captureResponseHeaders, useVersion: useVersion, needToValidateJson: needToValidateJson, completion: completion)
    } catch {
      completion(JSONResult.failure(error: error))
    }
  }

  class func post(url: URL,
                  jsonObject: JSONObject?,
                  captureResponseHeaders: Bool = false,
                  completion:@escaping (JSONResult) -> Void) {
    do {
      try connect(method: HTTPMethod.post.rawValue, url: url,
                  jsonObject:jsonObject, captureResponseHeaders: captureResponseHeaders,
                  completion: completion)
    } catch {
      completion(JSONResult.failure(error: error))
    }
  }
  
  class func post(path: String,
                  headers: [String:String]? = nil,
                  jsonObject: JSONObject?,
                  captureResponseHeaders: Bool = false,
                  useVersion: Bool = true,
                  completion:@escaping (JSONResult) -> Void) {
    do {
      try connect(method: HTTPMethod.post.rawValue, path: path, headers: headers,
                  jsonObject:jsonObject, captureResponseHeaders: captureResponseHeaders,
                  useVersion: useVersion, completion: completion)
    } catch {
      completion(JSONResult.failure(error: error))
    }
  }
}

// MARK: - Custom URLSession handling

extension URLSessionConfiguration {
  /// Just like defaultSessionConfiguration, returns a
  /// newly created session configuration object, customised
  /// from the default to your requirements.
  class func SessionConfiguration() -> URLSessionConfiguration {
    let headers = commonHeaders()
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = 60
    config.timeoutIntervalForResource = 60
    config.httpAdditionalHeaders = headers
    config.httpShouldUsePipelining = true
    return config
  }
  
  class func commonHeaders() -> [String : String] {
    var headers: [String : String] = [:]
    headers["Accept-Language"] = "EN"
    return headers
  }
}

// MARK: - Nice debug print

extension URLRequest {
  func nicePrint() {
    print("REST Request \(httpMethod ?? "") \(url?.absoluteString ?? "")")

    if let printHeaders = allHTTPHeaderFields, printHeaders.count > 0 {
      print(" Headers «\(printHeaders)»")
    }

    if httpBody != nil,
      let printBody = String(data: httpBody!, encoding: .utf8) {
      print(" Body «\(printBody)»")
    }
  }

  func prettyPrint() {
    print("\nREST Request \(httpMethod ?? "") \(url?.absoluteString ?? "")")

    var headers = [String: String]()
    
    let commonHeaders = URLSessionConfiguration.commonHeaders()
    commonHeaders.keys.forEach { (key) in
      headers[key] = commonHeaders[key]
    }
    
    if let allHttpHeaderFields = allHTTPHeaderFields {
      allHttpHeaderFields.keys.forEach({ (key) in
        headers[key] = allHttpHeaderFields[key]
      })
    }
    
    print(" Headers «\(headers)»")

    if let body = httpBody {
      do {
        let dict = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
        let jsonData = try JSONSerialization.data(withJSONObject: dict ?? [], options: .prettyPrinted)
        let printBody = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String

        print(" Body «\(printBody)»\n")
      } catch {
        print(error.localizedDescription)
      }

    }
  }
}

extension URLResponse {

  func nicePrint(data: Data?, error: Error?, for request: URLRequest) {

    let httpResponse = self as? HTTPURLResponse

    print("REST Response for \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")

    if let allHeaderFields = httpResponse?.allHeaderFields as? [String: String] {
      print(" Headers \(allHeaderFields)")
    }

    if let printStatus = httpResponse?.statusCode {
      print(" Status \(printStatus)")
    }

    if (data?.count ?? 0) > 0, let printData = String(data: data!, encoding: .utf8) {
      print(" Data «\(printData)»")
    }

    if error != nil {
      print(" Error «\(error?.localizedDescription ?? "")»")
    }
  }
}

// MARK: - JSON Validation

extension Rest : JSONValidation {
  static func validJson(from data: Data?, needToValidateJson: Bool) throws -> JSONObject {
    guard let responseData = data
      else { throw ReturnError.invalidJSON }

    // Convert JSON data to Swift JSON Object
    let responseJson = try JSONSerialization.jsonObject(with: responseData, options: [])
    guard let jsonObject = responseJson as? JSONObject
      else { throw ReturnError.invalidJSON }

    return jsonObject
  }
}
