import UIKit

enum Home
{
  typealias defaultDateConversion = TypeOfConversion.Type
  // MARK: Use cases
  enum CircleViewModel {
    struct LocationData {
      var humidity: KeyData?
      var temperature: String?
      var day: String?
      var imageName: String?
      var temperatureDesc: String?
      var wind: KeyData?
      var date: String?
      var time: String?
      var dateFromServer: String?
      var currentLocation: String?
      var precipitation: String?
      var pressureCheck: String?
      var weatherID: String?
      var weatherIconDesc: String?
      
      init(humidity: KeyData = KeyData(), temperature: String = "", day: String = "",
           imageName: String = "", temperatureDesc: String = "", wind: KeyData = KeyData(),
           date: String = "", time: String = "", dateFromServer: String = "",
           currentLocation: String = "", precipitation: String = "", pressureCheck: String = "",
           weatherID: String = "", weatherIconDesc: String = "") {
        self.humidity = humidity
        self.temperature = temperature
        self.day = convertDate(date: day, type: .Server)
        self.imageName = imageName
        self.temperatureDesc = temperatureDesc
        self.wind = wind
        self.date = convertDate(date: day, type: .DisplayDate)
        self.time = convertDate(date: day, type: .DisplayTime)
        self.dateFromServer = convertDate(date: day, type: .Sorting)
        self.currentLocation = currentLocation
        self.precipitation = precipitation
        self.pressureCheck = pressureCheck
        self.weatherID = weatherID
        self.weatherIconDesc = weatherIconDesc
      }
      
      mutating func getWeatherIcon(condition: Int = 0) -> String {
        switch (condition) {
        case 0...300 :
          return "tstorm1"
        case 301...500 :
          return "light_rain"
        case 501...600 :
          return "shower3"
        case 601...700 :
          return "snow4"
        case 701...771 :
          return "fog"
        case 772...799 :
          return "tstorm3"
        case 800 :
          return "sunny"
        case 801...804 :
          return "cloudy2"
        case 900...903, 905...1000  :
          return "tstorm3"
        case 903 :
          return "snow5"
        case 904 :
          return "sunny"
        default :
          return "dunno"
        }
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
    
    /// Data struct sent to ViewController
    struct ViewModel {
      let content: Content<[CircleViewModel.LocationData]>
    }
  }
}
