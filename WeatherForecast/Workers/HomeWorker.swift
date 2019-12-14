import Foundation

// MARK: - Deposit store API

protocol LocationStoreProtocol {
    func getLocations(request: Home.GetLocationResult.Request, completion: @escaping (Result<LocationResult>) -> Void)
}

class HomeWorker {
  
  // MARK: Business Logic
  var locationsStore: LocationStoreProtocol?

  init(with store: LocationStoreProtocol) {
    locationsStore = store
  }
  
  func getLocations(request: Home.GetLocationResult.Request, completion: @escaping (UserResult<LocationResult>) -> Void) {
    locationsStore?.getLocations(request: request, completion: { result in
        switch result {
        case .success(result: let resultSummary):
            completion(UserResult.success(result: resultSummary))
        case .failure(error: let error):
            completion(UserResult.failure(userError: error.userError()))
        }
    })
  }
}
