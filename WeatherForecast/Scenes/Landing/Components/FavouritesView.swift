//
//  ViewBookmarkCell.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 11/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
public class FavouritesView: UIView {
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var weatherIconImage: UIImageView!
  @IBOutlet weak var dayLabel: UILabel! {
    didSet {
      dayLabel.text = ""
      dayLabel.font = theme.fonts.headlineFontMediumNormal
      dayLabel.textColor = UIColor(named: "primaryTextColor")
    }
  }
  @IBOutlet weak var currentLocationLabel: UILabel! {
    didSet {
      currentLocationLabel.text = ""
      currentLocationLabel.font = theme.fonts.headlineFontMediumNormal
      currentLocationLabel.textColor = UIColor(named: "primaryTextColor")
    }
  }
  
  @IBOutlet weak var temperatureLabel: UILabel! {
    didSet {
      temperatureLabel.text = "---"
      temperatureLabel.font = theme.fonts.headlineFontMediumBig
      temperatureLabel.textColor = UIColor(named: "secondaryTextColor")
    }
  }
  
  @IBOutlet weak var timeWhenAddedToFav: UILabel! {
    didSet {
      timeWhenAddedToFav.text = "---"
      timeWhenAddedToFav.font = theme.fonts.bodyFont
      timeWhenAddedToFav.textColor = UIColor(named: "primaryTextColor")
    }
  }
  
  @IBOutlet weak var weatherDescriptionLabel: UILabel! {
    didSet {
      weatherDescriptionLabel.text = "---"
      weatherDescriptionLabel.font = theme.fonts.bodyFont
      weatherDescriptionLabel.textColor = UIColor(named: "primaryTextColor")
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed("FavouritesView", owner: self, options: nil)
    addSubview(view)
    view.frame = self.bounds
    view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    self.view.applyGradient()
  }
  
  func options(items: Home.CircleViewModel.HomeViewDataSourceModel) {
    let modelData = items.data.first
    currentLocationLabel.text = modelData?.currentLocation
    dayLabel.text = ""
    temperatureLabel.text = "\(modelData?.minTemp ?? 0) | \(modelData?.maxTemp ?? 0)"
    timeWhenAddedToFav.text = returnDateFormat(dateInMillis: modelData?.dt ?? 0)
    weatherDescriptionLabel.text = modelData?.temperatureDesc
    
//    let imageURL = Constants.BASE_IMAGE_URL + (modelData?.weatherIconDesc ?? Constants.defaultIcon ) + ".png"
//    guard let url = URL(string: imageURL) else { return }
//    weatherIconImage.load(url: url)
  }
}

