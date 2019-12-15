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
 // var pointAnnotation:MKPointAnnotation!
  var pinAnnotationView:MKPinAnnotationView!
  var annotation:MKAnnotation!
  var onBackButtonClick: ((_ tapped: Bool) -> Void)?
  
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
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
    mapView.delegate = self
  }
  
  func setNavigationBar() {
    self.navigationItem.title = "Set Bookmarks"
    let searchItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(onSearchButtonAction))
    
   // self.navigationItem.hidesBackButton = true
    let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(onBackClick))
   // self.navigationItem.leftBarButtonItem = newBackButton
    self.navigationItem.rightBarButtonItems = [searchItem]
  }
  
  @objc func onSearchButtonAction(sender: AnyObject){
    searchController = UISearchController(searchResultsController: nil)
    searchController.hidesNavigationBarDuringPresentation = false
    self.searchController.searchBar.delegate = self
    present(searchController, animated: true, completion: nil)
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
    request.units = "metric"
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
  
  func didNextTapped() {
    print("pin is clicked")
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if control == view.rightCalloutAccessoryView {
      if let doSomething = view.annotation?.title! {
        print("do something")
        // delegate?.didNextTapped()
      }
    }
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
    mapView.setRegion(region, animated: true)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error:: \(error)")
    
  }
}

extension MKMapViewController : UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
    
    searchBar.resignFirstResponder()
    dismiss(animated: true, completion: nil)
    if self.mapView.annotations.count != 0 {
      annotation = self.mapView.annotations[0]
      self.mapView.removeAnnotation(annotation)
    }
    
    localSearchRequest = MKLocalSearch.Request()
    localSearchRequest.naturalLanguageQuery = searchBar.text
    localSearch = MKLocalSearch(request: localSearchRequest)
    localSearch.start { (localSearchResponse, error) -> Void in
      
      if localSearchResponse == nil{
        let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        return
      }
      let locationOnMap = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
        self.showAlertForCustomBookmarkName(location: locationOnMap)

//      self.pointAnnotation = MKPointAnnotation()
//      self.pointAnnotation.title = searchBar.text
    //  self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
      
      
//      self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
//      self.mapView.centerCoordinate = self.pointAnnotation.coordinate
//      self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
    }
  }
}

extension MKMapViewController: MKMapViewControllerInterface {
  func saveDataToStorage(viewModel: Home.CircleViewModel.LocationData) {
    createData(model: [viewModel], mock: false)
    print(viewModel)
    retrieveData(complition: { bookMarks in
        print("******** \n")
        print(bookMarks)
    })
    self.mapView.showToast(message: "The location has been added to favourites", controller: self)
  }
}
