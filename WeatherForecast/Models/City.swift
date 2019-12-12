import Foundation
struct City : Codable {
	private(set) var id: Int?
	private(set) var name: String?
	private(set) var coord: Coord?
	private(set) var population: Int?
	private(set) var timezone: Int?
	private(set) var sunrise: Int?
	private(set) var sunset: Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case coord = "coord"
		case population = "population"
		case timezone = "timezone"
		case sunrise = "sunrise"
		case sunset = "sunset"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
		population = try values.decodeIfPresent(Int.self, forKey: .population)
		timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
		sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
		sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
	}

}
