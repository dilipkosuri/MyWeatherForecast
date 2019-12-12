import Foundation

class LocationsRestStore: LocationStoreProtocol {
  
  func getLocations(completion: @escaping (Result<LocationResult>) -> Void) {
    // Common mandatory fields
    let jsonParams: JSONSwiftObject = [
        "lat": "0",
        "lon": "0",
        "appid": "c6e381d8c7ff98f0fee43775817cf6ad",
        "units": "metric"
    ]
    
    let path =
    "http://api.openweathermap.org/data/2.5/forecast?lat=0&lon=0&appid=c6e381d8c7ff98f0fee43775817cf6ad&units=metric"
    
    ////EndPoint.getCurrentLocation.rawValue
    Rest.post(path: path, jsonObject: [:], captureResponseHeaders:true, useVersion:false) { result in
      do {
        switch result {
        case .success(let json):
          let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)

          let decoder = JSONDecoder()
          do {
              let customer = try decoder.decode(LocationResult.self, from: data)
              print(customer)
          } catch {
              print(error.localizedDescription)
          }
          
            guard let otpGenerateResult =
            DefaultJSONDecoder<[String: Any],LocationResult>.decode(json: json as [String : Any]) else {
              return
          }
          completion(Result.success(result: otpGenerateResult))
        case .failure(let error):
          throw error
        }
      } catch {
        completion(Result.failure(error: error))
      }
    }
  }
  
  enum EndPoint: String {
    case getCurrentLocation = "http://api.openweathermap.org/data/2.5/weather"
  }
  
}
