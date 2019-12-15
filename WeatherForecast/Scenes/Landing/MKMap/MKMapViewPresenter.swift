import UIKit

protocol MKMapViewPresentationInterface
{
  func presentCurrentWeatherDataToSaveToStorage(response: Home.GetLocationResult.CurrentWeatherResponse, locationName:String)
}

class MKMapViewPresenter: MKMapViewPresentationInterface
{
  weak var viewController: MKMapViewControllerInterface?
  typealias DisplayedClientList = Home.CircleViewModel
  typealias LandingScreenDataModel = Home.CircleViewModel.HomeViewDataSourceModel
  typealias DataModel = Home.CircleViewModel.LocationData
  var displayedClientList: DataModel = DataModel()
  
  func presentCurrentWeatherDataToSaveToStorage(response: Home.GetLocationResult.CurrentWeatherResponse, locationName:String) {
    typealias ViewModel = Home.GetLocationResult.ViewModel
    typealias DisplayedGroup = Home.CircleViewModel
    
    switch response.result {
      
    case .success(result: let locationData):
      let latitude: Double = locationData.coord?.lat ?? 0.0
      let longitude: Double = locationData.coord?.lon ?? 0.0

      displayedClientList = DisplayedClientList.LocationData(
        humidity: Home.CircleViewModel.KeyData(
          labelText: "Humidity",
          labelTextValue: "\(locationData.temperature?.humidity ?? 0)"),
        temperature: "\(locationData.temperature?.temp ?? 0)",
        day: "",
        imageName: "",
        temperatureDesc: locationData.weather?.first?.description ?? "",
        wind: Home.CircleViewModel.KeyData(
          labelText: "Wind",
          labelTextValue: "\(locationData.wind?.speed ?? 0)"),
        currentLocation: locationName,
        precipitation: "\(locationData.temperature?.temp_kf ?? 0)",
        pressureCheck: "\(locationData.temperature?.pressure ?? 0)",
        weatherID: "\(locationData.weather?.first?.id ?? 0)",
        weatherIconDesc: "\(locationData.weather?.first?.icon)",
        latitude: "\(latitude)",
        longitude: "\(longitude)"
      )
      viewController?.saveDataToStorage(viewModel: displayedClientList)
      break
    case .failure:
      break
    }
  }
}
