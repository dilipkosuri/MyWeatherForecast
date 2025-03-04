//
//  MKMapViewController.swift
//  WeatherForecast
//
//  Created by Dilip Kosuri on 12/12/19.
//  Copyright © 2019 Dilip Kosuri. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol MKMapViewControllerInterface: class
{
  func saveDataToStorage(viewModel: Home.CircleViewModel.LocationData)
}
protocol HandleMapSearch: class {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class MKMapViewController: UIViewController, Storyboarded {
  
  @IBOutlet weak var mapView: MKMapView!
  var interactor: LandingInteractorInterface?
  let locationManager = CLLocationManager()
  
  //Search
  var searchController:UISearchController!
  var localSearchRequest:MKLocalSearch.Request!
  var localSearch:MKLocalSearch!
  var localSearchResponse:MKLocalSearch.Response!
  var error:NSError!
  var pinAnnotationView:MKPinAnnotationView!
  var annotation:MKAnnotation!
  var onBackButtonClick: ((_ tapped: Bool) -> Void)?
  var resultSearchController: UISearchController!

  override func viewDidLoad() {
    super.viewDidLoad()
    setCurrentLocation()
    setNavigationBar()
    setupUI()
    let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
    mapView.addGestureRecognizer(longTapGesture)
  }
  
  // MARK: Setup
  private func setupUI()
  {
    let viewController = self
    let interactor = LandingInteractor()
    let mapPresenter = MKMapViewPresenter()
    viewController.interactor = interactor
    interactor.mapPresenter = mapPresenter
    mapPresenter.viewController = viewController as? MKMapViewControllerInterface
  }
    
  func setCurrentLocation() {
    mapView.showsUserLocation = true
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
  
  func setNavigationBar() {
    //Show only back arrow without text
    self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem()

    let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTableViewController
    resultSearchController = UISearchController(searchResultsController: locationSearchTable)
    resultSearchController.searchResultsUpdater = locationSearchTable
    let searchBar = resultSearchController!.searchBar
    searchBar.sizeToFit()
    searchBar.placeholder = "Search for places"
    navigationItem.titleView = resultSearchController?.searchBar
    resultSearchController.hidesNavigationBarDuringPresentation = false
    resultSearchController.dimsBackgroundDuringPresentation = true
    definesPresentationContext = true
    locationSearchTable.mapView = mapView
    locationSearchTable.handleMapSearchDelegate = self
  }
    
  @objc func longTap(sender: UIGestureRecognizer){
    if sender.state == .began {
      let locationInView = sender.location(in: mapView)
      let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
      showAlertForCustomBookmarkName(location: locationOnMap)
    }
  }
  
  @objc func onBackClick(sender: UIBarButtonItem) {
    onBackButtonClick?(true)
  }
    func showAlertForCustomBookmarkName(location: CLLocationCoordinate2D) {
        let alertController = UIAlertController(title: "Add title for bookmark", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                self.addAnnotation(location: location, title: text)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "bookmark name"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
  func addAnnotation(location: CLLocationCoordinate2D, title:String){
    let annotation = MKPointAnnotation()
    annotation.coordinate = location
    annotation.title = title
    //annotation.subtitle = "Some Subtitle"
    // current weather data fetch
    var request = Home.GetLocationResult.Request()
    request.latitude = "\(location.latitude)"
    request.longitude = "\(location.longitude)"
    
    if Constants.defaultTemperatureMetric == "fahrenheit" {
      request.units = "imperial"
    } else if Constants.defaultTemperatureMetric == "celcius" {
      request.units = "metric"
    } else {
      request.units = ""
    }
    // let requestDataFor: WeatherReportType = WeatherReportType.Forecast
    interactor?.getLocationByCoordinate(request: request, locationName: title)
    self.mapView.addAnnotation(annotation)
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: location, span: span)
    self.mapView.setRegion(region, animated: true)
  }
}

extension MKMapViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard !(annotation is MKUserLocation) else { return nil }
    guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
    
    let reuseId = "pin"
    var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
    
    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
      pinView!.canShowCallout = true
      pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
      pinView!.pinTintColor = UIColor.black
    }
    else {
      pinView!.annotation = annotation
    }
    return pinView
  }

}


extension MKMapViewController : CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      locationManager.requestLocation()
    }
  }
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else { return }
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: location.coordinate, span: span)
    self.mapView.setRegion(region, animated: true)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error:: \(error)")
    
  }
}

extension MKMapViewController: MKMapViewControllerInterface {
  func saveDataToStorage(viewModel: Home.CircleViewModel.LocationData) {
    createData(model: [viewModel], mock: false)
    print(viewModel)
//    retrieveData(complition: { _ in
//    })
    self.mapView.showToast(message: "The location has been added to favourites", controller: self)
  }
}
extension MKMapViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark){
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}
