
import UIKit

class SettingsViewController: UIViewController, Storyboarded, UIPickerViewDataSource, UIPickerViewDelegate {
 
  @IBOutlet weak var pickerMetric: UIPickerView!
  @IBOutlet weak var metricLabel: UILabel!
  @IBOutlet weak var metricTextLabel: UILabel!
  @IBOutlet weak var metricTemperatureTextLabel: UILabel!
  
  let pickerMetricData: [String] = Constants.unitsMeasurement
  let pickerTemperatureData: [String] = Constants.temperatureMeasurement
  var metricData: [[String]] = [[String]]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupConfiguration()
  }
  
  func setupConfiguration() {
    self.navigationItem.title = "Change preferences"
    self.pickerMetric.delegate = self
    self.pickerMetric.dataSource = self
    metricData = [pickerMetricData, pickerTemperatureData]
    self.pickerMetric.delegate = self
    self.pickerMetric.dataSource = self
    pickerMetric.selectRow(pickerMetricData.firstIndex(of: Constants.defaultUnitsMetric) ?? 0, inComponent: 0, animated: true)
    pickerMetric.selectRow(pickerTemperatureData.firstIndex(of: Constants.defaultTemperatureMetric) ?? 0, inComponent: 1, animated: true)
  }
  
  func setupUI() {
    metricLabel.textColor = UIColor(named: "highlightColor")
    metricLabel.text = "You may choose to change the default settings"
    metricLabel.font = self.view.theme.fonts.headlineFontMediumBig
    
    metricTextLabel.textColor = UIColor(named: "highlightColor")
    metricTextLabel.text = "Units"
    metricTextLabel.font = self.view.theme.fonts.headlineFontMediumBig
    
    metricTemperatureTextLabel.textColor = UIColor(named: "highlightColor")
    metricTemperatureTextLabel.text = "Temperature"
    metricTemperatureTextLabel.font = self.view.theme.fonts.headlineFontMediumBig
    
    self.view.applyGradient()
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
  return pickerMetricData.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
  return metricData[component][row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    if component == 0 {
      Constants.defaultUnitsMetric = String(pickerMetricData[row])
    }
    else{
      Constants.defaultTemperatureMetric = String(pickerTemperatureData[row])
    }
  }
  
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
    }
}
