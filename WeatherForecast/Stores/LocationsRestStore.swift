import Foundation

enum WeatherReportType {
  case CurrentWeather
  case Forecast
}

class LocationsRestStore: LocationStoreProtocol {
  
  enum EndPoint: String {
    case BaseURL = "http://api.openweathermap.org/data/2.5/forecast?"
    case API_Token = "c6e381d8c7ff98f0fee43775817cf6ad"
    case CurrentLocationURL = "http://api.openweathermap.org/data/2.5/weather?"
  }
  
  func getLocations(request: Home.GetLocationResult.Request, requestType type: WeatherReportType, completion: @escaping (Result<LocationResult>) -> Void) {
    
    var endpoint: String = ""
    let query = "lat=\(request.latitude!)&lon=\(request.longitude!)&appid=\(EndPoint.API_Token.rawValue)&units=\(request.units!)"
    
    
    switch type {
    case .CurrentWeather:
      endpoint = EndPoint.CurrentLocationURL.rawValue
    case .Forecast:
      endpoint = EndPoint.BaseURL.rawValue
    }
    
    Rest.get(path: endpoint, query: query, needToValidateJson: false, completion: { result in
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
    })
  }
}
