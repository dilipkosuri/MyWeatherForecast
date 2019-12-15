import UIKit
import CoreLocation
import CoreData

protocol LandingViewControllerInterface: class
{
  func displayLandingView(viewModel: [Home.CircleViewModel.HomeViewDataSourceModel])
}

class LandingViewController: UIViewController, Storyboarded, CLLocationManagerDelegate {
  
  @IBOutlet var landingView: UIView!
  var interactor: LandingInteractorInterface?
  let reuseIdentifier = "weatherCellIdentifier";
  internal var insideSpace: CGFloat = 8
  internal var insetEdgeSpace: CGFloat = 0
  @IBOutlet weak var collectionView: UICollectionView!
  internal var numberOfRecordsInStore: Int = 0
  internal var defaultIndexToShow: Int = 0
    internal var onAddButtonClick: ((_ tappedText: String) -> Void)?
    internal var onSettingsClick: ((_ tappedText: String) -> Void)?
  internal var onCollectionDidClick: ((_ tappedText: String) -> Void)?
  var bookMarkList = ["Dilip one", "Dilip two", "Dilip three"]
  var genericLocationData: [FavouriteDataModel] = []
  //var bookMarkList: [FavouriteDataModel] = [] // for empty
  typealias HomeScreenData = [Home.CircleViewModel.HomeViewDataSourceModel]
  
  // MARK: Object lifecycle
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  private func setup()
  {
    let viewController = self
    let interactor = LandingInteractor()
    let presenter = LandingPresenter()
    let mapPresenter = MKMapViewPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    interactor.mapPresenter = mapPresenter
    presenter.viewController = viewController
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupConfiguration()
    setNavigationBar()
  }
  
  func setupConfiguration() {
    self.landingView.applyGradient()
    //deleteData()
    var sampleData = [Home.CircleViewModel.LocationData]()
    //createData(model: sampleData, mock: true)
    var data: [Home.CircleViewModel.LocationData] = []
    //retrieveData()
    //bookMarkList = []
    fetchRecords()
  }
  
  func fetchRecords() {
    let bookmarkedList: [FavouriteDataModel] = retrieveData()
    var locationCoordinates: [String: String] = [:]
    if bookmarkedList.count > 0 {
      for item  in bookmarkedList {
        locationCoordinates[item.latitude] = item.longitude
        // call interactor to fetch each record item
        // call getLocations from interactor with WeatherReportType as CurrentWeather
      }
    }
  }
  
  func loadDetailsOfAnItem() {
    // load 5 days forcast
    // call interactor data getLocations with WeatherReportType as Forecast
  }
  
  func setNavigationBar() {
    let screenSize: CGRect = UIScreen.main.bounds
    let navBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: screenSize.width, height: 44))
    let navItem = UINavigationItem(title: "Weather Forecast")
    let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(onAddButtonTap))
    let settingsItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.organize, target: self, action: #selector(onSettingsButtonTapped))
    navItem.rightBarButtonItems = [addItem, settingsItem]
    navBar.setItems([navItem], animated: false)
    self.navigationItem.title = "Weather Forecast"
    self.navigationItem.rightBarButtonItems = [addItem, settingsItem]
  }
  
  @objc func onAddButtonTap(sender: AnyObject){
    self.onAddButtonClick?("Navigate to MK View")
  }
  
  @objc func onSettingsButtonTapped(sender: AnyObject){
    self.onSettingsClick?("Navigate to Settings View")
  }
}

extension LandingViewController: LandingViewControllerInterface {
  func displayLandingView(viewModel: [Home.CircleViewModel.HomeViewDataSourceModel])
  {
  }
}

