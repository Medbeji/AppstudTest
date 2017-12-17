//
//  Service.swift
//  InternshipTest
//
//  Created by MedBeji on 17/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import Foundation


struct Service {
    
    static let sharedInstance = Service()
    
    
    func nearbyPlaces(latitude: Double,longitude: Double,radius: Int = 2000) {
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyAAyWCYWfI5ZDdE2ZGJo8o0OqSWUJk-Who&location=\(latitude),\(longitude)&radius=\(radius)")
       
        
        
        
        
        
        
        
        
        
    }
}
