//
//  GenericUtilsTest.swift
//  WeatherForecastTests
//
//  Created by Dilip Kosuri on 14/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherForecast

class GenericUtilsTests: XCTestCase {
  var min_temp: Double?
  var max_temp: Double?
  var dateFromDT_TXT: String?
  var typeOfConversion: TypeOfConversion?
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
   setupUnitsData()
  }
  
  func setupUnitsData() {
    min_temp = 278.15
    max_temp = 281.5
    dateFromDT_TXT = "2017-01-30 21:00:00"
    typeOfConversion = TypeOfConversion.DisplayDate
  }
  
  func testConvertKelvinToFahrenheit() {
    let convertedMinValueIntoFahrenheit = getFahrenheit(valueInKelvin: min_temp)
    let convertedMaxValueIntoFahrenheit =  getFahrenheit(valueInKelvin: max_temp)
    
    XCTAssertEqual(convertedMinValueIntoFahrenheit, 41.0, "conversion of min_temp from Kelvin to fahrenheit is successful")
    XCTAssertEqual(convertedMaxValueIntoFahrenheit, 47.030000000000044, "conversion of max_temp from Kelvin to fahrenheit is successful")
  }
  
  func testConvertKelvinToCelcius() {
    let convertedMinValueIntoCelcius = getCelsius(valueInKelvin: min_temp)
    let convertedMaxValueIntoCelcius =  getCelsius(valueInKelvin: max_temp)
    
    XCTAssertEqual(convertedMinValueIntoCelcius, 5.0, "conversion of min_temp from Kelvin to fahrenheit is successful")
    XCTAssertEqual(convertedMaxValueIntoCelcius, 8.3500000000000234, "conversion of max_temp from Kelvin to fahrenheit is successful")
    
  }
  
  func testTimeOfDataCalculation() {
    let dateInMillis = timeOfDataCalculation(dateInMillis: 1485799200)
    XCTAssertTrue(dateInMillis > "02 Jan, 07:25 PM")
  }
  
  func testConvertDateFromServerIntoTime() {
    dateFromDT_TXT = "2017-01-30 21:00:00"
    XCTAssertEqual(convertDate(date:dateFromDT_TXT ?? "", type: TypeOfConversion.Server), "30-Jan", "conversion of min_temp from Kelvin to fahrenheit is successful")
     XCTAssertEqual(convertDate(date:dateFromDT_TXT ?? "", type: TypeOfConversion.Sorting), "30/Jan", "conversion of min_temp from Kelvin to fahrenheit is successful")
    
     XCTAssertTrue(convertDate(date:dateFromDT_TXT ?? "", type: TypeOfConversion.DisplayTime) > "14:57 PM")
     XCTAssertEqual(convertDate(date:dateFromDT_TXT ?? "", type: TypeOfConversion.DisplayDate), "30/Jan", "conversion of min_temp from Kelvin to fahrenheit is successful")
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
