import UIKit
import CoreLocation

protocol LandingViewControllerInterface: class
{
    func displayLandingView(viewModel: [Home.CircleViewModel.HomeViewDataSourceModel])
}

class LandingViewController: UIViewController, Storyboarded, CLLocationManagerDelegate {
    var interactor: LandingInteractorInterface?
    let reuseIdentifier = "weatherCellIdentifier";
    internal var insideSpace: CGFloat = 8
    internal var insetEdgeSpace: CGFloat = 0
    @IBOutlet weak var collectionView: UICollectionView!
    internal var numberOfRecordsInStore: Int = 0
    internal var defaultIndexToShow: Int = 0
    internal var onAddButtonClick: ((_ tappedText: String) -> Void)?
    let locationManager = CLLocationManager()
    var bookMarkList = ["Dilip one", "Dilip two", "Dilip three"]
   // var bookMarkList :[String] = [] // for empty
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
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.setNavigationBar()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)" )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        self.title = "Location unavailable"
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "Weather Forecast")
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(onAddButtonTap))
        let settingsItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(onSettingsButtonTapped))
        navItem.rightBarButtonItems = [addItem, settingsItem]
        navBar.setItems([navItem], animated: false)
        self.navigationItem.title = "Weather Forecast"
        self.navigationItem.rightBarButtonItems = [addItem, settingsItem]
    }
    
    @objc func onAddButtonTap(sender: AnyObject){
        self.onAddButtonClick?("Coordinator Pattern Demo")
    }
    
    @objc func onSettingsButtonTapped(sender: AnyObject){
        
    }
}

extension LandingViewController: LandingViewControllerInterface {
    func displayLandingView(viewModel: [Home.CircleViewModel.HomeViewDataSourceModel])
    {
    }
}

