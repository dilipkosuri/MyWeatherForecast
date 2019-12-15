import UIKit

enum Home
{
  typealias defaultDateConversion = TypeOfConversion.Type
  // MARK: Use cases
  enum CircleViewModel {
    struct LocationData {
      var humidity: KeyData?
      var temperature: String?
      var imageName: String?
      var temperatureDesc: String?
      var wind: KeyData?
      var currentLocation: String?
      var precipitation: String?
      var pressureCheck: String?
      var weatherID: String?
      var weatherIconDesc: String?
      var latitude: String?
      var longitude: String?
      var minTemp: Double?
      var maxTemp: Double?
      var dt: Double?
      var dateTime: String = ""
      
      init(humidity: KeyData = KeyData(), temperature: String = "",
           imageName: String = "", temperatureDesc: String = "", wind: KeyData = KeyData(),
           currentLocation: String = "", precipitation: String = "", pressureCheck: String = "",
           weatherID: String = "", weatherIconDesc: String = "", latitude: String = "", longitude: String = "",
           minTemp: Double = 0, maxTemp: Double = 0, dt: Double = 0, dateTime: String = "") {
        self.humidity = humidity
        self.temperature = temperature
        self.imageName = imageName
        self.temperatureDesc = temperatureDesc
        self.wind = wind
        self.currentLocation = currentLocation
        self.precipitation = precipitation
        self.pressureCheck = pressureCheck
        self.weatherID = weatherID
        self.weatherIconDesc = weatherIconDesc
        self.latitude = latitude
        self.longitude = longitude
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.dt = dt
        self.dateTime = dateTime
      }
    }
    
    struct KeyData {
      var labelText: String?
      var labelTextValue: String?
      
      init(labelText: String = "", labelTextValue: String = "") {
        self.labelText = labelText
        self.labelTextValue = labelTextValue
      }
    }
    
    struct HomeViewDataSourceModel {
      var date: String?
      var data: [Home.CircleViewModel.LocationData]
      
      init(date: String = "", data: [Home.CircleViewModel.LocationData] = []) {
        self.date = date
        self.data = data
      }
    }
  }
  
  enum GetLocationResult
  {
    struct Request {
      var latitude: String?
      var longitude: String?
      var units: String?
      
      init(latitude: String = "0", longitude: String = "0", units: String = "metric") {
        self.latitude = latitude
        self.longitude = longitude
        self.units = units
      }
    }
    /// Data struct sent to Presenter
    struct Response {
      let result: UserResult<(LocationResult)>
    }
    
    struct CurrentWeatherResponse {
      let result: UserResult<(LocationCurrentResult)>
    }
    
    /// Data struct sent to ViewController
    struct ViewModel {
      let content: Content<[CircleViewModel.LocationData]>
    }
  }
}
