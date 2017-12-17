//
//  MapVC.swift
//  TestApp
//
//  Created by MedBeji on 16/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import UIKit
import GoogleMaps


class MapVC: UIViewController,CLLocationManagerDelegate {
    
    
    // Location Manager

    let locationManager = CLLocationManager()
    
    // My Current Location
    var myCurrentLocation :  CLLocationCoordinate2D? {
       didSet {
            // Handle current location set
            if let myLocation = myCurrentLocation {
                 Service.sharedInstance.nearbyPlaces(latitude: myLocation.latitude,longitude: myLocation.longitude)
            }
        }
    }
    
    
    

    // Nearby Places Attribute
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request for your Position
        
        // Request for nearby places
        enableLocationServices()
       
        loadView()
    }
    
    
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    
    func enableLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            break
            
        case .restricted, .denied:
            // Disable location features
            disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse:
            // Enable basic location features
            enableMyWhenInUseFeatures()
            locationManager.startUpdatingLocation()
            break
            
        case .authorizedAlways:
            // Enable any of your app's location features
            enableMyAlwaysFeatures()
            locationManager.startUpdatingLocation()
            break
        }
    }
    
    
    func disableMyLocationBasedFeatures() {
        
    }
    func enableMyWhenInUseFeatures(){
        
    }
    func enableMyAlwaysFeatures(){
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.locationManager.stopUpdatingLocation()
            self.myCurrentLocation = location.coordinate
            return
        }
    }
    
    
    
}
    

