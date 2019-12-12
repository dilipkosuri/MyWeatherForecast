//
//  Storyboarded.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 9/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
  static func instantiate(with storyboardName: String) -> Self
}

enum StoryBoard: String {
  case Main
  case Home
  case Landing
  case Settings
  case City
  
  var value: String {
    return self.rawValue
  }
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(with storyBoardName: String) -> Self {
        let name = NSStringFromClass(self)
        let className = name.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
