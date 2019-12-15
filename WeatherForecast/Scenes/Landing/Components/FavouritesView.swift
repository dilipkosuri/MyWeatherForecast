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
        dayLabel.font = theme.fonts.subHeadlineFont
        dayLabel.textColor = UIColor(named: "primaryTextColor")
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
  }
    
    func options(items: [Home.CircleViewModel.HomeViewDataSourceModel],
                 intexPath: IndexPath) {
        let item = items[intexPath.row]
        currentLocationLabel.text = item.data.first?.currentLocation ?? ""
        temperatureLabel.text = item.data.first?.temperature ?? ""
        timeWhenAddedToFav.text = item.data.first?.time ?? ""
        weatherDescriptionLabel.text = item.data.first?.temperatureDesc ?? ""
        dayLabel.text = item.data.first?.day ?? ""
    }
}

