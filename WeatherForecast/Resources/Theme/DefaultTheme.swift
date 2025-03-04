//
//  DefaultTheme.swift
//  dopravaBrno
//
//  Created by Thành Đỗ Long on 07/04/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import Foundation
import UIKit

public struct DefaultTheme: ThemeStrategy {
    var fonts: FontScheme
    
    var barStyle: UIBarStyle = .default
    
    var keyboardAppearance: UIKeyboardAppearance = .default
    
    init(fonts: FontScheme = DefaultFonts()) {
        self.fonts = fonts
    }
    
    struct DefaultFonts: FontScheme {
        let headlineFontMediumNormal: UIFont = UIFont(name: "Montserrat-Medium", size: 20)!
        let headlineFontMediumBig: UIFont = UIFont(name: "Montserrat-Medium", size: 24)!
        
        let forecastHeadlineFont: UIFont = UIFont(name: "Montserrat-Semibold", size: 18)!
        let forecastSubHeadlineFont: UIFont = UIFont(name: "Montserrat-Medium", size: 14)!
        let forecastTemperatureFont: UIFont = UIFont(name: "Montserrat-Light", size: 24)!
        
        let bodyFont: UIFont = UIFont(name: "Montserrat-Medium", size: 14)!
        
        let tapBarFont: UIFont = UIFont(name: "Montserrat-Semibold", size: 10)!
        let navigationBarFont: UIFont = UIFont(name: "Montserrat-Medium", size: 16)!
    }
}
