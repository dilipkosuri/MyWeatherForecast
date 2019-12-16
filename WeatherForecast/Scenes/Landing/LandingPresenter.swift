import UIKit

protocol LandingPresentationInterface
{
  func presentCurrentDateDetail(response: Home.GetLocationResult.Response)
  func presentWeekDetail(response: Home.GetLocationResult.Response)
}

class LandingPresenter: LandingPresentationInterface {
  weak var viewController: LandingViewControllerInterface?
  typealias DisplayedClientList = Home.CircleViewModel
  typealias LandingScreenDataModel = Home.CircleViewModel.HomeViewDataSourceModel
  var displayedClientList: [Home.CircleViewModel.LocationData] = [Home.CircleViewModel.LocationData]()
  
  func presentCurrentDateDetail(response: Home.GetLocationResult.Response) {
    // need to use this if bookmarked items are individually called for updated data after the launch
    typealias ViewModel = Home.GetLocationResult.ViewModel
    typealias DisplayedGroup = Home.CircleViewModel
    
    switch response.result {
    
    case .success(result: let locationData):
      break
    case .failure:
      break
    }
  }
  
  func presentWeekDetail(response: Home.GetLocationResult.Response) {
  }
}
