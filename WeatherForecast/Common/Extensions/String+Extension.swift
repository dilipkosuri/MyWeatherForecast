//
//  String+Extension.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 16/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import Foundation

extension Double {
  /// Rounds the double to decimal places value
  func rounded(toPlaces places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
