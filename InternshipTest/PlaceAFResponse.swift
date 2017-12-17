//
//  PlaceRes.swift
//  InternshipTest
//
//  Created by MedBeji on 17/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import ObjectMapper

class PlaceAFResponse: Mappable {
    
    var html_attributions: [String]?
    var results: [Place]?
    var status: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        html_attributions <- map["html_attributions"]
        results <- map["results"]
        status <- map["status"]
    }
}

