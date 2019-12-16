import UIKit

protocol ThemeStrategy {
    var fonts: FontScheme {get}
    
    var barStyle: UIBarStyle { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
}

protocol FontScheme {
    var headlineFontMediumBig: UIFont {get}
    var headlineFontMediumNormal: UIFont {get}
    
    var forecastHeadlineFont: UIFont {get}
    var forecastSubHeadlineFont: UIFont {get}
    var forecastTemperatureFont: UIFont {get}
    
    var bodyFont: UIFont {get}
    
    var tapBarFont: UIFont {get}
    var navigationBarFont: UIFont {get}
}
