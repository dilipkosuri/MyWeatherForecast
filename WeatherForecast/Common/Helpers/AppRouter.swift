//
//  AppRouter.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 9/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import Foundation
import UIKit

public final class AppRouter: Coordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private let landingRouter: LandingRouter?
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        landingRouter = LandingRouter(navigationController: rootViewController)
    }
    
    public func start() {
        window.rootViewController = rootViewController
        landingRouter?.start()
        window.makeKeyAndVisible()
    }
}
