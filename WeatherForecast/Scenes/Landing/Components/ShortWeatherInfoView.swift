//
//  ShortWeatherInfoView.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 15/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import UIKit

class ShortWeatherInfoView: UIView {
  
  @IBOutlet weak var imageLabel: UIImageView! {
    didSet {
      let imageURL = Constants.BASE_IMAGE_URL+Constants.defaultIcon
      guard let url = URL(string: imageURL) else { return }
      imageLabel.load(url: url)
    }
  }
  
  @IBOutlet weak var descriptionLabel: UILabel! {
    didSet {
      descriptionLabel.text = "Forecast: "
      descriptionLabel.font = theme.fonts.headlineFont
      descriptionLabel.textColor = UIColor(named: "primaryTextColor")
    }
  }
  
  @IBOutlet weak var minTempLabel: UILabel! {
    didSet {
      minTempLabel.text = "Min:"
      minTempLabel.font = theme.fonts.forecastSubHeadlineFont
      minTempLabel.textColor = UIColor(named: "secondaryTextColor")
    }
  }
  @IBOutlet weak var maxTempLabel: UILabel! {
    didSet {
      maxTempLabel.text = "Max:"
      maxTempLabel.font = theme.fonts.forecastSubHeadlineFont
      maxTempLabel.textColor = UIColor(named: "secondaryTextColor")
    }
  }
  
  @IBOutlet weak var minTempLabelValue: UILabel! {
    didSet {
      minTempLabelValue.font = theme.fonts.forecastHeadlineFont
      minTempLabelValue.textColor = UIColor(named: "secondaryTextColor")
    }
  }
  @IBOutlet weak var maxTempLabelValue: UILabel! {
    didSet {
      maxTempLabelValue.font = theme.fonts.forecastHeadlineFont
      maxTempLabelValue.textColor = UIColor(named: "secondaryTextColor")
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  func options(model: FavouriteDataModel) {
   
    descriptionLabel.text = model.tempDesc
    minTempLabelValue.text = model.minTemp
    maxTempLabel.text = model.maxTemp
    
    let imageURL = Constants.BASE_IMAGE_URL + (model.icon ) + ".png"
    guard let url = URL(string: imageURL) else { return }
    imageLabel.load(url: url)
    
//    currentLocationLabel.text = model.currentLocation
//    humidityLabel.text = model.temperature + " | " + model.tempDesc
//    guard let url = URL(string: "http://openweathermap.org/img/w/"+model.icon+".png") else { return }
//    curentLocationImage.load(url: url)
    //temperatureLabel.text = model.temperature
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    let aView = Bundle.main.loadNibNamed("ShortWeatherInfoView", owner: self, options: nil)!.first as! UIView
    self.frame = aView.frame
    addSubview(aView)
  }
  
}
