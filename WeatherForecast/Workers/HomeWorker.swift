import Foundation

// MARK: - Deposit store API

protocol LocationStoreProtocol {
  func getLocations(completion: @escaping (Result<LocationResult>) -> Void)
}

class HomeWorker {
  
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

//////////////////////////////////////////
// MARK: - Mapping of known Backend errors
//////////////////////////////////////////

extension HomeWorker {
  static let errorMap: ErrorMap = [
    "1011": (type: UserError.ErrorType.discreet, message: nil)
  ]
}
