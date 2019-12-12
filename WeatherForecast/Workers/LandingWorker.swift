import Foundation

class LandingWorker {
  
  // MARK: Business Logic
  var locationsStore: LocationStoreProtocol?

  init(with store: LocationStoreProtocol) {
    locationsStore = store
  }
  
  func getLocations(completion: @escaping (UserResult<LocationResult>) -> Void) {
    locationsStore?.getLocations() { (result) in
      // Keep last result
      switch result {
      case .success(result: var resultSummary):
        completion(UserResult.success(result: resultSummary))
      case .failure(error: let error):
        completion(UserResult.failure(userError: error.userError()))
      }
    }
  }
}

