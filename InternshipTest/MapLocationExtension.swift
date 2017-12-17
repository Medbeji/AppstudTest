//
//  MapLocationExtension.swift
//  InternshipTest
//
//  Created by MedBeji on 17/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import UIKit
import GoogleMaps


extension MapVC: GMSMapViewDelegate, CLLocationManagerDelegate {
    
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
