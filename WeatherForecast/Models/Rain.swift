import Foundation
struct Rain: Codable {
	public private(set) var hoursMetric: Double?

	enum CodingKeys: String, CodingKey {

		case hoursMetric = "3h"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
      hoursMetric = try values.decodeIfPresent(Double.self, forKey: .hoursMetric)
	}

}
