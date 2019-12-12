import UIKit

protocol HomePresentationInterface
{
  func presentCurrentDateDetail(response: Home.GetLocationResult.Response)
  func presentWeekDetail(response: Home.GetLocationResult.Response)
}

class HomePresenter: HomePresentationInterface
{
  weak var viewController: HomeViewControllerInterface?
  typealias DisplayedClientList = Home.CircleViewModel
  typealias HomeScreenDataModel = Home.CircleViewModel.HomeViewDataSourceModel
  var displayedClientList: [Home.CircleViewModel.LocationData] = [Home.CircleViewModel.LocationData]()
  
  func presentCurrentDateDetail(response: Home.GetLocationResult.Response) {
    print("data: ******** \n")
    print(response)
    
    typealias ViewModel = Home.GetLocationResult.ViewModel
    typealias DisplayedGroup = Home.CircleViewModel
    
    switch response.result {
    
    case .success(result: let locationData):
        
        if let locationResponse = locationData.list {
            displayedClientList = (locationResponse.map {
                return DisplayedClientList.LocationData(
                        humidity: Home.CircleViewModel.KeyData(
                            labelText: "Humidity",
                            labelTextValue: "\($0.temperature?.humidity ?? 0)"),
                        temperature: "\($0.temperature?.temp ?? 0)",
                        day: $0.dt_txt ?? "",
                        imageName: "",
                        temperatureDesc: "",
                        wind: Home.CircleViewModel.KeyData(
                            labelText: "Wind",
                            labelTextValue: "\($0.wind?.speed ?? 0)"))
                })
        }
        
        // sort the elements as per date
        let sortedLocationData = displayedClientList.sorted(by: { $0.day?.compare($1.day ?? "") == .orderedDescending })
        
        // group the above sorted items as per date
        let groupedSortedLocationData = Dictionary(grouping: sortedLocationData, by: { $0.dateFromServer! })
       // var grouping = group.
        
        var homeScreenData = [HomeScreenDataModel]()
        // iterate the dictionary which is sorted and grouped by date and assign the values to the model for the UI rendering.
        for (key, value) in groupedSortedLocationData {
            homeScreenData.append(HomeScreenDataModel(date: key, data: value))
        }
        
        viewController?.displayCircleView(viewModel: homeScreenData)
    case .failure:
       print("Failed")
    }
  }
  
  func presentWeekDetail(response: Home.GetLocationResult.Response) {
    print("data")
  }
}
