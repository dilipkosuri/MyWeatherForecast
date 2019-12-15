import Foundation
struct Temperature: Codable {
	public private(set) var temp: Double?
	public private(set) var temp_min: Double?
	public private(set) var temp_max: Double?
	public private(set) var pressure: Int?
	public private(set) var sea_level: Int?
	public private(set) var grnd_level: Int?
	public private(set) var humidity: Int?
	public private(set) var temp_kf: Double?
    public private(set) var feels_like : Double?
  
	enum CodingKeys: String, CodingKey {

		case temp = "temp"
        case feels_like = "feels_like"
		case temp_min = "temp_min"
		case temp_max = "temp_max"
		case pressure = "pressure"
		case sea_level = "sea_level"
		case grnd_level = "grnd_level"
		case humidity = "humidity"
		case temp_kf = "temp_kf"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		temp = try values.decodeIfPresent(Double.self, forKey: .temp)
		temp_min = try values.decodeIfPresent(Double.self, forKey: .temp_min)
		temp_max = try values.decodeIfPresent(Double.self, forKey: .temp_max)
		pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
		sea_level = try values.decodeIfPresent(Int.self, forKey: .sea_level)
		grnd_level = try values.decodeIfPresent(Int.self, forKey: .grnd_level)
		humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
		temp_kf = try values.decodeIfPresent(Double.self, forKey: .temp_kf)
        feels_like = try values.decodeIfPresent(Double.self, forKey: .feels_like)
	}

}
