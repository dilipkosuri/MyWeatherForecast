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
}
