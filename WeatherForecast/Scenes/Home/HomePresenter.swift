import UIKit

protocol HomePresentationInterface
{
  func presentCurrentDateDetail(response: Home.GetLocationResult.Response)
  func presentWeekDetail(response: Home.GetLocationResult.Response)
}

class HomePresenter: HomePresentationInterface
{
  weak var viewController: HomeViewControllerInterface?
  typealias DisplayedClientList = Home.CircleViewModel
  typealias HomeScreenDataModel = Home.CircleViewModel.HomeViewDataSourceModel
  var displayedClientList: [Home.CircleViewModel.LocationData] = [Home.CircleViewModel.LocationData]()
  
  func presentCurrentDateDetail(response: Home.GetLocationResult.Response) {
    typealias ViewModel = Home.GetLocationResult.ViewModel
    typealias DisplayedGroup = Home.CircleViewModel
    
    switch response.result {
    case .success(result: let locationData):
      let latitude: Double = locationData.city?.coord?.lat ?? 0.0
      let longitude: Double = locationData.city?.coord?.lon ?? 0.0
      
      if let locationResponse = locationData.list {
        displayedClientList = (locationResponse.map {
          return DisplayedClientList.LocationData(
            humidity: Home.CircleViewModel.KeyData(
              labelText: "Humidity",
              labelTextValue: "\($0.temperature?.humidity ?? 0)"),
            temperature: "\($0.temperature?.temp ?? 0)",
            imageName: "",
            temperatureDesc: $0.weather?.first?.description ?? "",
            wind: Home.CircleViewModel.KeyData(
              labelText: "Wind",
              labelTextValue: "\($0.wind?.speed ?? 0)"),
            currentLocation: "",
            precipitation: "\($0.temperature?.temp_kf ?? 0)",
            pressureCheck: "\($0.temperature?.pressure ?? 0)",
            weatherID: "\($0.weather?.first?.id ?? 0)",
            weatherIconDesc: $0.weather?.first?.icon ?? "",
            latitude: "\(latitude)",
            longitude: "\(longitude)",
            minTemp: $0.temperature?.temp_min ?? 0,
            maxTemp: $0.temperature?.temp_max ?? 0,
            dt: Double($0.dt ?? 0),
            dateTime: timeOfDataCalculation(dateInMillis: Double($0.dt ?? 0)),
            dateFromServer: convertDate(date:$0.dt_txt ?? "", type: .Server))
        })
      }
      
      // sort the elements as per date
      let sortedLocationData = displayedClientList.sorted(by: { $0.dateFromServer.compare($1.dateFromServer) == .orderedDescending })
      
      // group the above sorted items as per date
      let groupedSortedLocationData = Dictionary(grouping: sortedLocationData, by: { $0.dateFromServer })
      // var grouping = group.
      
      var homeScreenData = [HomeScreenDataModel]()
      // iterate the dictionary which is sorted and grouped by date and assign the values to the model for the UI rendering.
      for (key, value) in groupedSortedLocationData {
        homeScreenData.append(HomeScreenDataModel(date: key, data: value))
      }
      self.viewController?.setupCardView(items: homeScreenData)
      viewController?.displayCircleView(viewModel: homeScreenData)
    case .failure:
      print("Failed")
    }
  }
  
  func presentWeekDetail(response: Home.GetLocationResult.Response) {
    print("data")
  }
}
