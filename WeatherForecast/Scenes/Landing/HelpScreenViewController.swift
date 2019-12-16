//
//  HelpScreenViewController.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 16/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class HelpScreenViewController: UIViewController, WKNavigationDelegate, Storyboarded {
  
  @IBOutlet weak var webView: WKWebView!
  
  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "Web_Assets")!
    webView.loadFileURL(url, allowingReadAccessTo: url)
    let request = URLRequest(url: url)
    webView.load(request)
    webView.allowsBackForwardNavigationGestures = true
    self.view.applyGradient()
    webView.backgroundColor = UIColor.clear
  }
}
