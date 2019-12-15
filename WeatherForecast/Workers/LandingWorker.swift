import Foundation

class LandingWorker {
  
  // MARK: Business Logic
  var locationsStore: LocationStoreProtocol?
  
  init(with store: LocationStoreProtocol) {
    locationsStore = store
  }
  
  func getLocations(request: Home.GetLocationResult.Request, completion: @escaping (UserResult<LocationResult>) -> Void) {
    locationsStore?.getLocations(request: request) { (result) in
      switch result {
      case .success(result: let resultSummary):
        completion(UserResult.success(result: resultSummary))
      case .failure(error: let error):
        completion(UserResult.failure(userError: error.userError()))
      }
    }
  }
  
  func getCurrentWeather(request: Home.GetLocationResult.Request,
                         completion: @escaping (UserResult<LocationCurrentResult>) -> Void) {
    locationsStore?.getCurrentWeather(request: request, completion: { result in
      switch result {
      case .success(result: let resultSummary):
        completion(UserResult.success(result: resultSummary))
      case .failure(error: let error):
        completion(UserResult.failure(userError: error.userError()))
      }
    })
  }
}

