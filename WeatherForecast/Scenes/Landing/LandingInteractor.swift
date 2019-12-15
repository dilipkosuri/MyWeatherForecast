import UIKit

protocol LandingInteractorInterface
{
  func getLocations(request: Home.GetLocationResult.Request)
  func getLocationByCoordinate(request: Home.GetLocationResult.Request)
}

class LandingInteractor: LandingInteractorInterface
{
  var presenter: LandingPresentationInterface?
  var mapPresenter: MKMapViewPresenter?
  var landingWorker = LandingWorker(with: LocationsRestStore())
  var generateLocationResult: LocationResult?
  var generatedCurrentLocationResult: LocationCurrentResult?
  
  func getLocations(request: Home.GetLocationResult.Request) {
    landingWorker.getLocations(request: request) { [weak self] userResult in
      if case .success(let result) = userResult {
        self?.generateLocationResult = result
      }
      let response = Home.GetLocationResult.Response(result: userResult)
      self?.presenter?.presentCurrentDateDetail(response: response)
    }
  }
  
  func getLocationByCoordinate(request: Home.GetLocationResult.Request) {
    landingWorker.getCurrentWeather(request: request) { userResult in
      if case .success(let result) = userResult {
        self.generatedCurrentLocationResult = result
      }
      let response = Home.GetLocationResult.CurrentWeatherResponse(result: userResult)
      self.mapPresenter?.presentCurrentWeatherDataToSaveToStorage(response: response)
    }
  }
}
