import UIKit

public final class LandingRouter: Coordinator
{
  private let navigationController: UINavigationController
  
  // MARK: Routing
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: Navigation
  public func start() {
//    let landingVC = LandingViewController.instantiate(with: "Landing")
//    self.navigationController.navigationBar.isHidden = false
//    landingVC.onAddButtonClick = doNavigation
//    navigationController.pushViewController(landingVC, animated: true)
    
    let mkMapVC = MKMapViewController.instantiate(with: "Landing")
       self.navigationController.navigationBar.isHidden = false
       navigationController.pushViewController(mkMapVC, animated: true)
  }
  
  private func doNavigation(tappedText: String) {
    let mkMapVC = MKMapViewController.instantiate(with: "Landing")
    self.navigationController.navigationBar.isHidden = false
    navigationController.pushViewController(mkMapVC, animated: true)
  }
  
}
