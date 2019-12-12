import Foundation

struct Status {
  let code: String
  let description: String?
}

// ============================================================================= //
// MARK: - Models initializers
// ============================================================================= //

extension Status {
  init(from json: JSONObject?) throws {

    var codeValue: Any?
    var descriptionValue: String?

    if let codeField = json?["code"] {
      codeValue = codeField
      descriptionValue = json?["description"] as? String
    } else if let codeField = json?["statuscode"] {
      codeValue = codeField
      descriptionValue = json?["statusdesc"] as? String
    }

    // "code" is required, try to read as String and as Int
    switch codeValue {
    case let stringValue as String: code = stringValue
    case let intValue as Int: code = String(intValue)
    default: throw ReturnError.invalidJSON
    }

    description = descriptionValue
  }
}
