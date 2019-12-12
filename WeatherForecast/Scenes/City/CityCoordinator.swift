import Foundation
import UIKit

public final class CityCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
  
    public func start() {
        let cityVC = CityViewController.instantiate(with: "City")
        self.navigationController.navigationBar.isHidden = true
        cityVC.doNavigation = doNavigation
        navigationController.pushViewController(cityVC, animated: true)
    }
    
    private func doNavigation(tappedText: String) {
        let cityVC = CityViewController.instantiate(with: "City")
       // cityVC.str = tappedText
        navigationController.pushViewController(cityVC, animated: true)
    }
}
