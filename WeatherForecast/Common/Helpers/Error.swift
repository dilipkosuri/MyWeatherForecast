import Foundation

enum ValidationError: Error {
  case missing(String)
  case invalid(String, Any)
}

enum ReturnError: Error {
  case apiError(code: String, message: String?)
  case invalidJSON
}

enum Result<T> {
  case success(result: T)
  case failure(error: Error)
}

// MARK: High level

enum UserResult<T> {
  case success(result: T)
  case failure(userError: UserError)
}

struct UserError: Error {
  let type: ErrorType
  let message: String
  
  enum ErrorType {
    case terminate
    case offline
    case alert
    case discreet
  }
}

enum Content<T> {
  case empty
  case error
  case userError(UserError)
  case success(data: T)
}

typealias ErrorMap = [String: (type: UserError.ErrorType, message: String?)]

extension UserError {
  /// Given an ErrorMap, return the UserError for a specific status code
  init?(for code: String, description: String? = nil,
        with errorMap: ErrorMap) {
    
    guard let (type, message) = errorMap[code]
      else { return nil }
    
    self = UserError(type: type, message: message ?? "")
  }
  
  static func generic() -> UserError {
    return UserError(type: .alert, message: "")
  }
}

extension UserResult {
  static func genericFailure() -> UserResult {
    return UserResult.failure(userError: UserError.generic())
  }
}

// MARK: Usefull types convertion envolving ErrorMap
extension Error {
  /// Converts any Error to an UserError
  func userError(with errorMap: ErrorMap? = nil) -> UserError {
    // Imediate case
    if let userError = self as? UserError {
      return userError
    }
    
    // If there's an error map and self is an API Error, try to create a UserError from there
    if let returnError = self as? ReturnError,
      case let .apiError(code: code, message: message) = returnError {
      if let errorMap = errorMap, let userError = UserError(for: code, description: message, with: errorMap) {
        return userError
      }
      if let message = message {
        return UserError(type: .alert, message: message)
      }
    }
    return UserError.generic()
  }
}

extension Result {
  /// Converts any Result to an UserResult
  func userResult(with errorMap: ErrorMap? = nil) -> UserResult<T> {
    switch self {
    case .success(result: let any):
      return UserResult<T>.success(result: any)
    case .failure(error: let error):
      return UserResult<T>.failure(userError: error.userError(with: errorMap))
    }
  }
}
