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
        
      init(humidity: KeyData = KeyData(), temperature: String = "", day: String = "",
           imageName: String = "", temperatureDesc: String = "", wind: KeyData = KeyData(),
           date: String = "", time: String = "", dateFromServer: String = "") {
        self.humidity = humidity
        self.temperature = temperature
        self.day = convertDate(date: day, type: .Server)
        self.imageName = imageName
        self.temperatureDesc = temperatureDesc
        self.wind = wind
        self.date = convertDate(date: day, type: .DisplayDate)//UTCToLocal(date: day, fromFormat: "YYYY-MM-dd hh:mm:ss", toFormat: "dd MMM yyyy")
        self.time = convertDate(date: day, type: .DisplayTime)//getCurrentTime()
        self.dateFromServer = convertDate(date: day, type: .Sorting)//getCurrentDateTimeFromString(dateStr: day)
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
