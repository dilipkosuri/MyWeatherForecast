import UIKit

protocol LandingInteractorInterface
{
  func getLocations(request: Home.GetLocationResult.Request, requestType: WeatherReportType)
}

protocol LandingDataStore
{
  //var name: String { get set }
}

class LandingInteractor: LandingInteractorInterface, LandingDataStore
{
  var presenter: LandingPresentationInterface?
  var landingWorker = LandingWorker(with: LocationsRestStore())
  var generateLocationResult: LocationResult?
  //var name: String = ""
  
  // MARK: Do something
  func getLocations(request: Home.GetLocationResult.Request, requestType: WeatherReportType) {
    landingWorker.getLocations(request: request, requestType: requestType) { [weak self] userResult in
      if case .success(let result) = userResult {
        self?.generateLocationResult = result
      }
      let response = Home.GetLocationResult.Response(result: userResult)
      self?.presenter?.presentCurrentDateDetail(response: response)
    }
  }
}
