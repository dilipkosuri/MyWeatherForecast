import Foundation
struct List: Codable {
	public private(set) var dt : Int?
	public private(set) var temperature: Temperature?
	public private(set) var weather: [Weather]?
	public private(set) var clouds: Clouds?
	public private(set) var wind: Wind?
	public private(set) var rain: Rain?
	public private(set) var rainfall: Rainfall?
	public private(set) var dt_txt: String?

	enum CodingKeys: String, CodingKey {

		case dt = "dt"
		case temperature = "main"
		case weather = "weather"
		case clouds = "clouds"
		case wind = "wind"
		case rain = "rain"
		case rainfall = "sys"
		case dt_txt = "dt_txt"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dt = try values.decodeIfPresent(Int.self, forKey: .dt)
      temperature = try values.decodeIfPresent(Temperature.self, forKey: .temperature)
		weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
		clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
		wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
		rain = try values.decodeIfPresent(Rain.self, forKey: .rain)
      rainfall = try values.decodeIfPresent(Rainfall.self, forKey: .rainfall)
		dt_txt = try values.decodeIfPresent(String.self, forKey: .dt_txt)
	}

}
