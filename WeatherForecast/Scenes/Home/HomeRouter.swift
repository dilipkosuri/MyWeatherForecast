import UIKit

@objc protocol HomeRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

class HomeRouter: NSObject, Coordinator
{
  weak var viewController: HomeViewController?
  private let navigationController: UINavigationController
  private var cityCoordinator: CityCoordinator?
  
  // MARK: Routing
  init(navigationController: UINavigationController) {
      self.navigationController = navigationController
  }
  

  // MARK: Navigation
  public func start() {
      let homeVC = HomeViewController.instantiate(with: "Home")
      self.navigationController.navigationBar.isHidden = true
      /// Either set delegate or assign closure to get the call back.
      homeVC.delegate = self
    //  tutorialVC.doNavigation = doNavigation
      navigationController.pushViewController(homeVC, animated: true)
  }
  
  
  // MARK: Passing data
  
  
}

extension HomeRouter: HomeViewControllerDelegate {
    public func didNextTapped() {
        // Do Navigation
       let cityCoordinator = CityCoordinator(navigationController: navigationController)
       self.cityCoordinator = cityCoordinator
       cityCoordinator.start()
    }
}
