//
//  TodayView.swift
//  ViewBookmarkCell.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 14/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

struct FavouriteDataModel {
  var icon: String = ""
  var currentLocation: String = ""
  var temperature: String = ""
  var humidity: String = ""
  var precipitation: String = ""
  var pressureCheck: String = ""
  var wind: String = ""
  var date: String = ""
  var tempDesc: String = ""
  var longitude: String = ""
  var latitude: String = ""
  var minTemp: String = ""
  var maxTemp: String = ""
}

import UIKit

public class TodayView: UIView {
  //@IBOutlet weak var view: UIView!
  @IBOutlet weak var navigationBar: UINavigationBar! {
    didSet {
      let attrs: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor(named: "primaryTextColor")!,
        .font: theme.fonts.navigationBarFont
      ]
      
      navigationBar.titleTextAttributes = attrs
    }
  }
  
  @IBOutlet weak var weatherIconImage: UIImageView!
  
  @IBOutlet weak var curentLocationImage: UIImageView! {
    didSet {
      curentLocationImage.isHidden = false
    }
  }
  
  @IBOutlet weak var currentLocationLabel: UILabel! {
    didSet {
      currentLocationLabel.text = ""
      currentLocationLabel.font = theme.fonts.headlineFontMediumBig
      currentLocationLabel.textColor = UIColor(named: "highlightColor")
    }
  }
  
  @IBOutlet weak var temperatureLabel: UILabel! {
    didSet {
      temperatureLabel.text = "---"
      temperatureLabel.font = theme.fonts.forecastHeadlineFont
      temperatureLabel.textColor = UIColor(named: "secondaryTextColor")
    }
  }
  
  @IBOutlet weak var humidityLabel: UILabel! {
    didSet {
      humidityLabel.text = "---"
      humidityLabel.font = theme.fonts.bodyFont
      humidityLabel.textColor = UIColor(named: "secondaryColor")
    }
  }
  
  @IBOutlet weak var precipitationLabel: UILabel! {
    didSet {
      precipitationLabel.text = "---"
      precipitationLabel.font = theme.fonts.bodyFont
      precipitationLabel.textColor = UIColor(named: "primaryTextColor")
    }
  }
  
  @IBOutlet weak var pressureLabel: UILabel! {
    didSet {
      pressureLabel.text = "---"
      pressureLabel.font = theme.fonts.bodyFont
      pressureLabel.textColor = UIColor(named: "primaryTextColor")
    }
  }
  
  @IBOutlet weak var windSpeedLabel: UILabel! {
    didSet {
      windSpeedLabel.text = "---"
      windSpeedLabel.font = theme.fonts.bodyFont
      windSpeedLabel.textColor = UIColor(named: "primaryTextColor")
    }
  }
  
  @IBOutlet weak var windDirectionLabel: UILabel! {
    didSet {
      windDirectionLabel.text = "---"
      windDirectionLabel.font = theme.fonts.bodyFont
      windDirectionLabel.textColor = UIColor(named: "primaryTextColor")
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  func options(model: FavouriteDataModel) {
    currentLocationLabel.text = model.currentLocation
    humidityLabel.text = model.temperature + " | " + model.tempDesc
    guard let url = URL(string: "http://openweathermap.org/img/w/"+model.icon+".png") else { return }
    curentLocationImage.load(url: url)
    //temperatureLabel.text = model.temperature
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    let aView = Bundle.main.loadNibNamed("TodayView", owner: self, options: nil)!.first as! UIView
    self.frame = aView.frame
    addSubview(aView)
    self.clipsToBounds = true
    self.layer.cornerRadius = 10
  }
  
}
