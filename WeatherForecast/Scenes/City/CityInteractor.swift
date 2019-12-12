import UIKit

protocol CityBusinessLogic
{
  //func doSomething(request: City.Something.Request)
}

protocol CityDataStore
{
  //var name: String { get set }
}

class CityInteractor: CityBusinessLogic, CityDataStore
{
  var presenter: CityPresentationLogic?
  var worker: CityWorker?
  //var name: String = ""
  
  // MARK: Do something
  
//  func doSomething(request: City.Something.Request)
//  {
//    worker = CityWorker()
//    worker?.doSomeWork()
//    
//    let response = City.Something.Response()
//    presenter?.presentSomething(response: response)
//  }
}
