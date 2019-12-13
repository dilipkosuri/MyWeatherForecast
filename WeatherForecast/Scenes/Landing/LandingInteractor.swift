import UIKit

protocol LandingInteractorInterface
{
  func getLocations(request: Home.GetLocationResult.Request)
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
  func getLocations(request: Home.GetLocationResult.Request) {
    landingWorker.getLocations(request: request) { [weak self] userResult in
      if case .success(let result) = userResult {
        self?.generateLocationResult = result
      }
      let response = Home.GetLocationResult.Response(result: userResult)
      self?.presenter?.presentCurrentDateDetail(response: response)
    }
  }
}
