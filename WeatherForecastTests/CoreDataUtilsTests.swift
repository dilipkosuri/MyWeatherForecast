//
//  CoreDataUtilsTests.swift
//  WeatherForecastTests
//
//  Created by Dilip Kosuri on 14/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//
import Foundation
import CoreData
import UIKit
import XCTest
@testable import WeatherForecast

class CoreDataUtilsTests: XCTestCase {
  var model = [Home.CircleViewModel.LocationData]()
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    model = [Home.CircleViewModel.LocationData(
      humidity: Home.CircleViewModel.KeyData(
        labelText: "HumidityLabel",labelTextValue: "HumidityValue"),
      temperature:"23.6",
      imageName: "10d",
      temperatureDesc: "Light Rain",
      wind: Home.CircleViewModel.KeyData(
        labelText: "WindLabel", labelTextValue: "WindValue"),
      currentLocation: "Singapore",
      precipitation: "1016",
      pressureCheck: "83.7",
      weatherID: "13232",
      weatherIconDesc: "10d",
      latitude: "172.27862822",
      longitude: "-127.97878779",
      minTemp: 219.87,
      maxTemp: 288.22,
      dt: 15276767,
      dateTime: "2017-01-30 21:00:00",
      dateFromServer: "2017-01-30 21:00:00")]
  }
  
  func testConvertKelvinToFahrenheit() {
    createData(model: model, mock: false)
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteDataSourceModel")
    do {
      let result: [NSManagedObject] = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
      XCTAssertTrue(result.count > 0)
      XCTAssertEqual(result.count, 1, "One record is inserted into the application local storage")
      deleteData()
    } catch {
      XCTAssertFalse(false, "Count not equal to 1")
    }
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
