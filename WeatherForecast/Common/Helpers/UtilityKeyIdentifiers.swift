//
//  UtilityKeyIdentifiers.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 14/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import Foundation


class Constants {
  
  static var unitsMeasurement = ["standard", "metric", "imperial"]
  static var BASE_IMAGE_URL = "http://openweathermap.org/img/w/"
  static var defaultIcon = "01d.png"
  static var temperatureMeasurement = ["fahrenheit", "celcius", "kelvin"]
  
  static var defaultUnitsMetric = "metric"
  static var defaultTemperatureMetric = "kelvin"
  
  /*
   
   Temperature is available in Fahrenheit, Celsius and Kelvin units.

   For temperature in Fahrenheit use units=imperial
   For temperature in Celsius use units=metric
   Temperature in Kelvin is used by default, no need to use units parameter in API call
   
   */
  
  
  
}
