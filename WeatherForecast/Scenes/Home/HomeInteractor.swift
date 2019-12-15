import UIKit

protocol HomeInteractorInterface
{
  func getLocations(request: Home.GetLocationResult.Request, requestType: WeatherReportType)
}

protocol HomeDataStore
{
  //var name: String { get set }
}

class HomeInteractor: HomeInteractorInterface, HomeDataStore
{
  var presenter: HomePresentationInterface?
  var homeWorker = HomeWorker(with: LocationsRestStore())
  var generateLocationResult: LocationResult?
  //var name: String = ""
  
  // MARK: Do something
  func getLocations(request: Home.GetLocationResult.Request, requestType: WeatherReportType) {
    homeWorker.getLocations(request: request) { [weak self] userResult in
      if case .success(let result) = userResult {
        self?.generateLocationResult = result
      }
      let response = Home.GetLocationResult.Response(result: userResult)
      self?.presenter?.presentCurrentDateDetail(response: response)
    }
  }
}
