//
//  ViewExt.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 11/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  var theme: ThemeStrategy {
    return DefaultTheme()
  }
  
  func fadeTransition(delay: Double = 0.0, duration: Double = 0.5) {
    alpha = 0
    
    UIView.animate(
      withDuration: duration,
      delay: delay,
      animations: {
        self.alpha = 1
    })
  }
  
  func applyGradient() {
    let colorTop =  UIColor(red: 54.0/255.0, green: 209.0/255.0, blue: 220.0/255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 91.0/255.0, green: 134.0/255.0, blue: 229.0/255.0, alpha: 1.0).cgColor
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorTop, colorBottom]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.frame = self.bounds
    
    self.layer.insertSublayer(gradientLayer, at:0)
  }
}
