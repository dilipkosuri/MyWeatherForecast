import UIKit

/// Important : Any tap in VC can be handled using closure or delegate function.
public protocol HomeViewControllerDelegate: class {
  func didNextTapped()
}

protocol HomeViewControllerInterface: class
{
  func setupCardView(items: [Home.CircleViewModel.HomeViewDataSourceModel])
  func displayCircleView(viewModel: [Home.CircleViewModel.HomeViewDataSourceModel])
}

class HomeViewController: UIViewController, HomeViewControllerInterface, Storyboarded
{
  var interactor: HomeInteractorInterface?
  var router: (NSObjectProtocol)?
  @IBOutlet var homeScreenView: UIView!
  internal weak var delegate: HomeViewControllerDelegate?
  @IBOutlet weak var humidityLabelText: UILabel!
  @IBOutlet weak var humidityLabelValue: UILabel!
  @IBOutlet weak var temperature: UILabel!
  @IBOutlet weak var temperatureBasedImage: UIImageView!
  @IBOutlet weak var date: UILabel!
  @IBOutlet weak var weatherDescription: UILabel!
  @IBOutlet weak var windDescription: UILabel!
  @IBOutlet weak var localTime: UILabel!
  
  @IBOutlet weak var circleView: CircleView!
  @IBOutlet weak var circleTitleLabel: UILabel!
  @IBOutlet weak var contentStackView: UIStackView!
  
  typealias HomeScreenData = [Home.CircleViewModel.HomeViewDataSourceModel]
  var cardViewController:CardViewController!
  
  var cardHeight:CGFloat  {
    return self.view.frame.height * 0.6
  }
  var cardHandleAreaHeight:CGFloat = 65
  
  enum CardState {
    case expanded
    case collpased
  }
  //
  var favModel: FavouriteDataModel?
  var cardVisible = false
  var nextState:CardState {
    return cardVisible ? .collpased : .expanded
  }
  
  
  // Animation
  var animations:[UIViewPropertyAnimator] = []
  var currentAnimationProgress:CGFloat = 0
  var animationProgressWhenIntrupped:CGFloat = 0
  
  
  // visual effects
  
  var visualEffectView: UIVisualEffectView!
  
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
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter(navigationController: self.navigationController ?? UINavigationController())
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  @IBAction private func nextTapped(_ sender: UIButton) {
    // using closure
    // doNavigation()
    
    // using delegate
    delegate?.didNextTapped()
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    setupConfiguration()
    setupUI()
  }
  
  func setupUI() {
    self.view.bringSubviewToFront(circleTitleLabel)
    self.view.sendSubviewToBack(circleView)
    humidityLabelText.font = humidityLabelText.font.withSize(24)
    humidityLabelValue.font = humidityLabelValue.font.withSize(32)
    temperature.font = temperature.font.withSize(32)
    date.font = date.font.withSize(32)
    weatherDescription.font = weatherDescription.font.withSize(20)
    localTime.font = localTime.font.withSize(20)
    humidityLabelText.textColor = UIColor.white
    humidityLabelValue.textColor = UIColor.white
    temperature.textColor = UIColor.white
    date.textColor = UIColor.white
    windDescription.textColor = UIColor.white
    weatherDescription.textColor = UIColor.white
    localTime.textColor = UIColor.white
    windDescription.font = windDescription.font.withSize(24)
    temperatureBasedImage.backgroundColor = UIColor.clear
    self.homeScreenView.applyGradient()
    contentStackView.superview?.bringSubviewToFront(contentStackView)
  }
  
  func setupCircleUI(input: HomeScreenData) {
    if input.count > 0 {
      let model = input.first?.data.first
      humidityLabelText.text = model?.humidity?.labelText ?? "-"
      humidityLabelValue.text = model?.humidity?.labelTextValue ?? "-"
      temperature.text = model?.temperature ?? "-"
      date.text = model?.dateTime ?? "-"
      weatherDescription.text = model?.temperatureDesc ?? ""
      windDescription.text = (model?.wind?.labelText ?? "-") + "" + (model?.wind?.labelTextValue ?? "-")
      //localTime.text = model?.time ?? "-"
      
      let imageURL = Constants.BASE_IMAGE_URL + (model?.weatherIconDesc ?? Constants.defaultIcon) + ".png"
      
      guard let url = URL(string: imageURL) else { return }
      temperatureBasedImage.load(url: url)
    }
  }
  
  // MARK: Do something
  func setupConfiguration()
  {
    self.view.backgroundColor =
      UIColor(patternImage: UIImage(named: "rainfall.png") ?? UIImage())
    if let model = favModel {
      print("favModel \(model)")
      var request = Home.GetLocationResult.Request()
      request.latitude = model.latitude
      request.longitude = model.longitude
      var requestDataFor: WeatherReportType = WeatherReportType.Forecast
      interactor?.getLocations(request: request, requestType: requestDataFor)
    }
    
  }
  
  func displayCircleView(viewModel: [Home.CircleViewModel.HomeViewDataSourceModel])
  {
    setupCircleUI(input: viewModel)
  }
}

extension HomeViewController {
    func setupCardView(items: [Home.CircleViewModel.HomeViewDataSourceModel]) {
        visualEffectView = UIVisualEffectView(frame: self.view.bounds)
        self.view.addSubview(visualEffectView)
        
        cardViewController = CardViewController(nibName:"CardViewController",bundle:nil)
        cardViewController.items = items
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x:0,y:self.view.frame.height - cardHandleAreaHeight,width:self.view.frame.width,height:cardHeight)
        cardViewController.view.clipsToBounds = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned(recognizer:)))
        cardViewController.handlerArea.addGestureRecognizer(panGestureRecognizer)
  }
  
  @objc func panned(recognizer:UIPanGestureRecognizer) {
    
    switch recognizer.state {
    case .began:
      startIntractiveAnimation(state: nextState, duration: 0.9)
    case .changed:
      let translation =  recognizer.translation(in: self.cardViewController.handlerArea)
      let fractionCompleted = translation.y / cardHeight
      let fraction = cardVisible ? fractionCompleted : -fractionCompleted
      updateIntractiveAnimation(animationProgress: fraction)
    case .ended:
      
      continueAnimation(finalVelocity: recognizer.velocity(in: self.cardViewController.handlerArea))
    default:
      break
    }
    
  }
  
  func createAnimation(state:CardState,duration:TimeInterval) {
    
    guard animations.isEmpty else {
      print("Animation not empty")
      return
      
    }
    
    print("array count",self.animations.count)
    
    let cardMoveUpAnimation = UIViewPropertyAnimator.init(duration: duration, dampingRatio: 1.0) { [weak self] in
      guard let `self` = self else  {return}
      switch state {
      case .collpased:
        self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
      case .expanded:
        self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
      }
    }
    cardMoveUpAnimation.addCompletion { [weak self] _ in
      
      self?.cardVisible =  state ==  .collpased ? false : true
      self?.animations.removeAll()
    }
    cardMoveUpAnimation.startAnimation()
    animations.append(cardMoveUpAnimation)
    
    let cornerRadiusAnimation = UIViewPropertyAnimator(duration: duration, curve: .linear) { [weak self] in
      switch state {
      case .expanded:
        self?.cardViewController.view.layer.cornerRadius = 12
      case .collpased:
        self?.cardViewController.view.layer.cornerRadius = 0
      }
    }
    cornerRadiusAnimation.startAnimation()
    animations.append(cornerRadiusAnimation)
    
    let visualEffectAnimation = UIViewPropertyAnimator.init(duration: duration, curve: .linear) { [weak self ] in
      switch state {
      case .expanded:
        self?.visualEffectView.effect = UIBlurEffect(style: .dark)
        
      case .collpased:
        self?.visualEffectView.effect =  nil
      }
    }
    visualEffectAnimation.startAnimation()
    animations.append(visualEffectAnimation)
  }
  
  func startIntractiveAnimation(state:CardState,duration:TimeInterval) {
    if animations.isEmpty {
      createAnimation(state: state, duration: duration)
      // Create Animations
    }
    // Here we are pause the animation and get fraction Complete value and store it. so when use change the animation we can update animation.fractionComplete in next method
    for animation in animations {
      animation.pauseAnimation()
      animationProgressWhenIntrupped = animation.fractionComplete
    }
  }
  
  func updateIntractiveAnimation(animationProgress:CGFloat)  {
    for animation in animations {
      //     print(animationProgress + animationProgressWhenIntrupped)
      animation.fractionComplete = animationProgress + animationProgressWhenIntrupped
      // print(animation.fractionComplete)
    }
  }
  
  func continueAnimation(finalVelocity:CGPoint) {
    print(cardVisible == (finalVelocity.y < 0))
    if cardVisible == (finalVelocity.y < 0) {
      var completedFraction:CGFloat = 0
      for animation in animations {
        completedFraction = animation.fractionComplete
        animation.stopAnimation(true)
        
      }
      animations.removeAll()
      self.cardVisible =  !self.cardVisible
      self.createAnimation(state: nextState, duration: TimeInterval(completedFraction * 0.9))
    } else {
      for animation in animations {
        animation.continueAnimation(withTimingParameters: nil, durationFactor: 0)
      }
    }
  }
}
