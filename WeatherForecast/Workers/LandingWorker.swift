import Foundation

class LandingWorker {
  
  // MARK: Business Logic
  var locationsStore: LocationStoreProtocol?

  init(with store: LocationStoreProtocol) {
    locationsStore = store
  }
  
  func getLocations(request: Home.GetLocationResult.Request, requestType: WeatherReportType, completion: @escaping (UserResult<LocationResult>) -> Void) {
        locationsStore?.getLocations(request: request, requestType: requestType) { (result) in
      switch result {
      case .success(result: var resultSummary):
        completion(UserResult.success(result: resultSummary))
      case .failure(error: let error):
        completion(UserResult.failure(userError: error.userError()))
      }
    }
  }
}

