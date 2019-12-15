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
  
  func showToast(message : String, controller: UIViewController) {
    
    let toastContainer = UIView(frame: CGRect())
    toastContainer.backgroundColor = UIColor(named: "showToast")!
    toastContainer.alpha = 0.0
    toastContainer.clipsToBounds  =  true
    
    let toastLabel = UILabel(frame: CGRect())
    toastLabel.textColor = UIColor(named: "highlightColor")!
    toastLabel.font = theme.fonts.forecastTemperatureFont
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.clipsToBounds  =  true
    toastLabel.numberOfLines = 0

    toastContainer.addSubview(toastLabel)
    controller.view.addSubview(toastContainer)

    toastLabel.translatesAutoresizingMaskIntoConstraints = false
    toastContainer.translatesAutoresizingMaskIntoConstraints = false

    let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
    let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
    let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
    let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
    toastContainer.addConstraints([a1, a2, a3, a4])

    let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 0)
    let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -0)
    let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -0)
    controller.view.addConstraints([c1, c2, c3])

    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
      toastContainer.alpha = 1.0
    }, completion: { _ in
      UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
        toastContainer.alpha = 0.0
      }, completion: {_ in
        toastContainer.removeFromSuperview()
      })
    })
  }
  
}

extension UIImageView {
    func load(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
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
