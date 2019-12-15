import UIKit
import CoreLocation
import CoreData

protocol LandingViewControllerInterface: class
{
  func displayLandingView(viewModel: [Home.CircleViewModel.HomeViewDataSourceModel])
}

class LandingViewController: UIViewController, Storyboarded {
  
  var interactor: LandingInteractorInterface?
  let reuseIdentifier = "weatherCellIdentifier";
  internal var insideSpace: CGFloat = 8
  internal var insetEdgeSpace: CGFloat = 0
  @IBOutlet weak var collectionView: UICollectionView!
  internal var numberOfRecordsInStore: Int = 0
  internal var defaultIndexToShow: Int = 0
  internal var onAddButtonClick: ((_ tappedText: String) -> Void)?
  internal var onSettingsClick: ((_ tappedText: String) -> Void)?
  internal var onCollectionDidClick: ((_ favModel: FavouriteDataModel) -> Void)?
  
  var genericLocationData: [FavouriteDataModel] = []
  var bookmarkedList: [FavouriteDataModel] = []
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
    self.view.applyGradient()
    fetchRecords()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(false)
    fetchRecords()
  }
  
  func fetchRecords() {
    bookmarkedList = []
    retrieveData(complition: { bookMarks in
        if bookMarks.count > 0 {
            bookmarkedList = bookMarks
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    })
  }
  
  func loadDetailsOfAnItem() {
    // load 5 days forcast
    // call interactor data getLocations with WeatherReportType as Forecast
  }
  
  func setNavigationBar() {
    let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(onAddButtonTap))
    //let settingsItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.organize, target: self, action: #selector(onSettingsButtonTapped))
    self.navigationItem.title = "Weather Forecast"
    self.navigationItem.rightBarButtonItems = [addItem] //[addItem, settingsItem]
  }
  
  @objc func onAddButtonTap(sender: AnyObject){
    self.onAddButtonClick?("Navigate to MK View")
  }
  
  @objc func onSettingsButtonTapped(sender: AnyObject){
    self.onSettingsClick?("Navigate to Settings View")
  }
    
    @IBAction func settingButtonAction(_ sender: Any) {
        self.onSettingsClick?("Navigate to Settings View")
    }
    
    @IBAction func helpButtonAction(_ sender: Any) {
    }
}

extension LandingViewController: LandingViewControllerInterface {
  func displayLandingView(viewModel: [Home.CircleViewModel.HomeViewDataSourceModel])
  {
  }
}

