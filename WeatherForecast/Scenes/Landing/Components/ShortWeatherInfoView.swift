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
      descriptionLabel.font = theme.fonts.headlineFontMediumBig
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
  
    @IBOutlet weak var imageView_3AM: UIImageView!
    @IBOutlet weak var label_3AM: UILabel!
    
    @IBOutlet weak var imageView_9AM: UIImageView!
    @IBOutlet weak var label_9AM: UILabel!

    @IBOutlet weak var imageView_6PM: UIImageView!
    @IBOutlet weak var label_6PM: UILabel!
    
    @IBOutlet weak var imageView_9PM: UIImageView!
    @IBOutlet weak var label_9PM: UILabel!
    override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
    func options(model: [Home.CircleViewModel.HomeViewDataSourceModel], dateKey: String, cellSize: CGSize) {
        self.frame.size = cellSize
        let aView = Bundle.main.loadNibNamed("ShortWeatherInfoView", owner: self, options: nil)!.first as! UIView
        aView.frame = self.frame
        addSubview(aView)
        self.layoutSubviews()
        self.layoutIfNeeded()
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        descriptionLabel.text = dateKey //model.temperatureDesc

        let newModel : [Home.CircleViewModel.HomeViewDataSourceModel] = model.filter({ $0.date == dateKey })
        print("newModel \(newModel)")
        if newModel.count > 0 {
            let locationData : [Home.CircleViewModel.LocationData] = newModel[0].data
            for item in locationData {
                
                if item.dateTime.contains("03:00:00") {
                    let imageURL = Constants.BASE_IMAGE_URL + (item.weatherIconDesc ?? Constants.defaultIcon ) + ".png"
                    if let url = URL(string: imageURL) {
                        self.imageView_3AM.loadImage(url: url)
                    }
                    self.label_3AM.text = item.temperature
                } else if item.dateTime.contains("09:00:00") {
                    let imageURL = Constants.BASE_IMAGE_URL + (item.weatherIconDesc ?? Constants.defaultIcon ) + ".png"
                    if let url = URL(string: imageURL) {
                        self.imageView_9AM.loadImage(url: url)
                    }
                    self.label_9AM.text = item.temperature
                } else if item.dateTime.contains("15:00:00") {
                    let imageURL = Constants.BASE_IMAGE_URL + (item.weatherIconDesc ?? Constants.defaultIcon ) + ".png"
                    if let url = URL(string: imageURL) {
                        self.imageView_6PM.loadImage(url: url)
                    }
                    self.label_6PM.text = item.temperature
                } else if item.dateTime.contains("21:00:00") {
                    let imageURL = Constants.BASE_IMAGE_URL + (item.weatherIconDesc ?? Constants.defaultIcon ) + ".png"
                    if let url = URL(string: imageURL) {
                        self.imageView_9PM.loadImage(url: url)
                    }
                    self.label_9PM.text = item.temperature
                }
            }
        }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
   
  }
}

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
