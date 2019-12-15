import UIKit

public final class LandingRouter: Coordinator
{
  private let navigationController: UINavigationController
  var onBackButtonTap: ((_ tapped: Bool) -> Void)?
  
  // MARK: Routing
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: Navigation
  public func start() {
    let landingVC = LandingViewController.instantiate(with: "Landing")
    landingVC.onAddButtonClick = doNavigation
    landingVC.onCollectionDidClick = doNavigationToHomeVC
    landingVC.onSettingsClick = doNavigationToSettingsVC
    navigationController.pushViewController(landingVC, animated: true)
  }
  
  private func doNavigation(tappedText: String) {
    let mkMapVC = MKMapViewController.instantiate(with: "Landing")
    mkMapVC.onBackButtonClick = { _ in
      self.onBackButtonTap?(true)
    }
    self.navigationController.navigationBar.isHidden = false
    navigationController.pushViewController(mkMapVC, animated: true)
  }
    private func doNavigationToHomeVC(tappedText: String) {
        let homeVC = HomeViewController.instantiate(with: "Home")
        navigationController.pushViewController(homeVC, animated: true)
    }
    private func doNavigationToSettingsVC(tappedText: String) {
        let settingsVC = SettingsViewController.instantiate(with: "Landing")
        navigationController.pushViewController(settingsVC, animated: true)
    }
}
