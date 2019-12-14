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
}

import UIKit

public class TodayView: UIView {
  @IBOutlet weak var view: UIView!
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
      curentLocationImage.isHidden = true
    }
  }
  
  @IBOutlet weak var currentLocationLabel: UILabel! {
    didSet {
      currentLocationLabel.text = ""
      currentLocationLabel.font = theme.fonts.subHeadlineFont
      currentLocationLabel.textColor = UIColor(named: "primaryTextColor")
    }
  }
  
  @IBOutlet weak var temperatureLabel: UILabel! {
    didSet {
      temperatureLabel.text = "---"
      temperatureLabel.font = theme.fonts.headlineFont
      temperatureLabel.textColor = UIColor(named: "secondaryTextColor")
    }
  }
  
  @IBOutlet weak var humidityLabel: UILabel! {
    didSet {
      humidityLabel.text = "---"
      humidityLabel.font = theme.fonts.bodyFont
      humidityLabel.textColor = UIColor(named: "primaryTextColor")
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
  
  @IBOutlet weak var shareButton: UIButton! {
    didSet {
      shareButton.setTitleColor(UIColor(named: "shareColor"), for: .normal)
      shareButton.titleLabel?.font = theme.fonts.subHeadlineFont
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  func options(model: FavouriteDataSourceModel) {
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("TodayView", owner: self, options: nil)
    addSubview(view)
    view.frame = self.bounds
    view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
  
}
