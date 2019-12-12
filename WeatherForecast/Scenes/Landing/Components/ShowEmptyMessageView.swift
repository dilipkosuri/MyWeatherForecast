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
public class ShowEmptyMessageView: UIView {
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var weatherIconImage: UIImageView!
  @IBOutlet weak var primaryTextLabel: UILabel! {
    didSet {
      primaryTextLabel.text = "Looks like you have not pinned your favourite locations yet."
      primaryTextLabel.font = theme.fonts.subHeadlineFont
      primaryTextLabel.textColor = UIColor(named: "primaryTextColor")
    }
  }
  
  @IBOutlet weak var helpTextSecondary: UILabel! {
    didSet {
      helpTextSecondary.text = "just add it up.. click on + above and hook it up"
      helpTextSecondary.font = theme.fonts.subHeadlineFont
      helpTextSecondary.textColor = UIColor(named: "primaryTextColor")
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
    Bundle.main.loadNibNamed("ShowEmptyMessageView", owner: self, options: nil)
    addSubview(view)
    view.frame = self.bounds
    view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
}
