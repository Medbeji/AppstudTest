//
//  Place.swift
//  InternshipTest
//
//  Created by MedBeji on 17/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import ObjectMapper



class Place: Mappable {
    
    var name: String?
    var id: String?
    var place_id: String?
    var latitude: Double?
    var longitude: Double?
    var photo_reference: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
        place_id <- map["place_id"]
        latitude <- map["geometry.location.lat"]
        longitude <- map["geometry.location.lng"]
        photo_reference <- map["photos.0.photo_reference"]
    }
    
}
