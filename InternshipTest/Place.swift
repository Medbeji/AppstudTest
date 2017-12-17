//
//  Place.swift
//  InternshipTest
//
//  Created by MedBeji on 17/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import Foundation


struct Place {
    
    var name: String = ""
    var imageUrlRef: String = ""
    var id: String = ""
    
    init(json: [String: AnyObject]) {
        if let id = json["id"] as? String {
            self.id = id
        }
        if let name = json["name"] as? String {
            self.name = name
        }
        if let imageUrlRef = json["name"] as? String {
            self.imageUrlRef = imageUrlRef
        }
    }
    
}
