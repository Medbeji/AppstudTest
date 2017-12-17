//
//  MapVC.swift
//  TestApp
//
//  Created by MedBeji on 16/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import UIKit
import GoogleMaps


class MapVC: UIViewController {
    
    // NearbyPlaces
    var nearbyPlaces: [Place]? {
        didSet {
            if let nearbyplaces = nearbyPlaces {
                self.drawMarkers(places: nearbyplaces)
            }
        }
    }
    
    func drawMarkers(places: [Place]){
        for place in places {
            let marker = CustomMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.latitude!, longitude: place.longitude!)
            // Disable interaction as APPSTUD-04 requires
            marker.isTappable = false
            // Set image to marker asynchronously
            if let imageRef = place.photo_reference {
                Service.sharedInstance.downloadImage(imageRef: imageRef, completion: { (image) in
                    if let image = image {
                        marker.imageView.image = image
                    }
                })
            }
            // Add marker to the map
            marker.map = self.mapView
        }
    }
    
    var locationManager = CLLocationManager()

    
    // My Location 
    var myLocation: CLLocation?
    
    // Google Maps Properties
    var camera: GMSCameraPosition?
    var mapView: GMSMapView?
    
   
    
    // Nearby Places Attribute
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
    }
    
    
    // Override the loadView method from UIViewController
    override func loadView() {
        self.camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera!)
        self.mapView!.isMyLocationEnabled = true
        view = mapView
    }

    
}



extension MapVC: GMSMapViewDelegate,CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        NSLog("My position changed")
        
        // Update my location property of the class
        self.myLocation = locations.last!
        
        // Get lat and long from the current postion
        guard let lat = self.mapView?.myLocation?.coordinate.latitude else { return }
        guard let long = self.mapView?.myLocation?.coordinate.longitude else { return }
        
        // Fetch nearby places based on the current coordinates
        Service.sharedInstance.nearbyPlaces(latitude: lat, longitude: long) { (places) in
            self.nearbyPlaces = places
        }
        
        // Center camera on user location
        let update = GMSCameraUpdate.setTarget((self.mapView?.myLocation?.coordinate)!, zoom: 15.0)
        self.mapView?.moveCamera(update)
        
        // Pass this postion the listVC
        let navController = tabBarController?.viewControllers?.last as! UINavigationController
        let listVC = navController.viewControllers.first as! ListVC
        listVC.location = self.mapView?.myLocation

    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            self.mapView?.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }


  
    
}
    

