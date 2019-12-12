import UIKit

protocol CityPresentationLogic
{
  func presentSomething(response: LocationResult)
}

class CityPresenter: CityPresentationLogic
{
  weak var viewController: CityDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: LocationResult)
  {
   // let viewModel = City.Something.ViewModel()
    //viewController?.displaySomething(viewModel: viewModel)
  }
}
