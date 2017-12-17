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
                // Pass these places to the list controller
                let navController = tabBarController?.viewControllers?.last as! UINavigationController
                let listVC = navController.viewControllers.first as! ListVC
                listVC.places = nearbyplaces
            }
        }
    }
    

    // LocationManager property to detect position changes
    var locationManager = CLLocationManager()
    
    
    // My Location
    var myLocation: CLLocation?
    
    // Google Maps Properties
    var camera: GMSCameraPosition?
    var mapView: GMSMapView?
    
   
    
    // Nearby Places Attribute
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Map"
        locationSettings()
        
    }
    
    // Setup Location settings
    func locationSettings(){
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
    
    // Draw Marker for each place
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
    
    
}



    

