import UIKit
import Foundation

class SettingsViewController: UIViewController, Storyboarded, UIPickerViewDataSource, UIPickerViewDelegate {
  
  
  @IBOutlet weak var myTextField: UITextField!
  @IBOutlet weak var myLabel: UILabel!
  @IBOutlet weak var topPickerView: UIPickerView!
  @IBOutlet weak var metricLabel: UILabel!
  @IBOutlet weak var resetBookmarks: UIButton!
  
  var arrayOf2 = Array(1...2)
  
  var labelString = ""
  let anotherPicker = UIPickerView()
  
  let pickerMetricData: [String] = Constants.unitsMeasurement
  let pickerTemperatureData: [String] = Constants.temperatureMeasurement
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    topPickerView.delegate = self
    
    topPickerView.delegate?.pickerView?(topPickerView, didSelectRow: pickerTemperatureData.firstIndex(of: Constants.defaultTemperatureMetric) ?? 0, inComponent: 0)
    topPickerView.selectRow(pickerTemperatureData.firstIndex(of: Constants.defaultTemperatureMetric) ?? 0,
                            inComponent: 0, animated: true)
    createAnotherPicker()
    createToolbar()
    setupUI()
    self.view.applyGradient()
  }
  
  func createAnotherPicker() {
    anotherPicker.delegate = self
    anotherPicker.delegate?.pickerView?(anotherPicker, didSelectRow: pickerMetricData.firstIndex(of: Constants.defaultUnitsMetric) ?? 0, inComponent: 0)
    anotherPicker.selectRow(pickerMetricData.firstIndex(of: Constants.defaultUnitsMetric) ?? 0,
                            inComponent: 0, animated: true)
    myTextField.inputView = anotherPicker
  }
  
  func createToolbar() {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closePickerView))
    toolbar.setItems([doneButton], animated: false)
    toolbar.isUserInteractionEnabled = true
    myTextField.inputAccessoryView = toolbar
  }
  
  func setupUI() {
    myLabel.textColor = UIColor(named: "highlightColor")
    myLabel.text = "Metric setting "
    myLabel.font = self.view.theme.fonts.headlineFontMediumBig
    
    metricLabel.textColor = UIColor(named: "highlightColor")
    metricLabel.text = "Temperature setting "
    metricLabel.font = self.view.theme.fonts.headlineFontMediumBig
    
    resetBookmarks.setTitleColor(UIColor(named: "highlightColor"), for: .normal)
    resetBookmarks.titleLabel?.font = self.view.theme.fonts.headlineFontMediumBig
    resetBookmarks.backgroundColor = UIColor(named: "primaryTextColor")
    resetBookmarks.setTitle("Reset Bookmarks", for: .normal)
    
  }
  
  @IBAction func resetBookmarks(_ sender: UIButton) {
    deleteData()
  }
  
  @objc func closePickerView() {
    view.endEditing(true)
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == topPickerView{
      return pickerTemperatureData.count
    } else{
      return pickerMetricData.count
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
  {
    if pickerView == topPickerView{
      return String(pickerTemperatureData[row])
    } else{
      return String(pickerMetricData[row])
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == topPickerView{
      Constants.defaultTemperatureMetric = String(pickerTemperatureData[row])
      //myLabel.text = "Temperature set as: \(dropdownValue)"
      print(String(pickerTemperatureData[row]))
    }
    else{
      myTextField.text =  pickerMetricData[row]
      Constants.defaultUnitsMetric = String(pickerMetricData[row])
    }
  }
}

