import UIKit

protocol LandingViewControllerInterface: class
{
  func displayLandingView(viewModel: [Home.CircleViewModel.HomeViewDataSourceModel])
}

class LandingViewController: UIViewController, Storyboarded {
  var interactor: LandingInteractorInterface?
  let reuseIdentifier = "CellIdentifer";
  internal var insideSpace: CGFloat = 8
  internal var insetEdgeSpace: CGFloat = 0
  @IBOutlet weak var collectionView: UICollectionView!
  internal var numberOfRecordsInStore: Int = 0
  internal var defaultIndexToShow: Int = 0
  internal var onAddButtonClick: ((_ tappedText: String) -> Void)?
  
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
      self.setNavigationBar()
  }

  func setNavigationBar() {
      let screenSize: CGRect = UIScreen.main.bounds
      let navBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: screenSize.width, height: 44))
      let navItem = UINavigationItem(title: "Weather Forecast")
      let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: nil, action: #selector(onAddButtonTap))
      let settingsItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: nil, action: #selector(onSettingsButtonTapped))
      navItem.rightBarButtonItems = [addItem, settingsItem]
      navBar.setItems([navItem], animated: false)
    
      self.view.addSubview(navBar)
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

