import Foundation
struct Rainfall: Codable {
	public private(set) var pod: String?

	enum CodingKeys: String, CodingKey {

		case pod = "pod"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pod = try values.decodeIfPresent(String.self, forKey: .pod)
	}

}
