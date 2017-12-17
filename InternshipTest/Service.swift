//
//  Service.swift
//  InternshipTest
//
//  Created by MedBeji on 17/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import AlamofireImage

class Service {
    
    // Singleton instance
    static let sharedInstance = Service()
    
    // Attributes for services
    fileprivate let baseNearbyPlacesUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/"
    fileprivate let baseImageURL = "https://maps.googleapis.com/maps/api/place/photo"
    fileprivate let format = "json"
    fileprivate let apiKey = "AIzaSyAAyWCYWfI5ZDdE2ZGJo8o0OqSWUJk-Who"
    fileprivate let searchType = "restaurant"
    fileprivate let maxThumbnailWidth = 100
    fileprivate let maxImageWidth = 1000
    fileprivate let radius = 2000
    
    func nearbyPlaces(latitude: Double,longitude: Double, completion: @escaping (([Place]) -> () ) ) {
   
        var urlString = "\(baseNearbyPlacesUrl)\(format)?key=\(apiKey)&location=\(latitude),\(longitude)&radius=\(radius)&type=\(searchType)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(urlString).responseObject { (response: DataResponse<PlaceAFResponse>) in
            let placeResponse = response.result.value
            if let results = placeResponse?.results {
                completion(results)
            }else{
                completion([])
            }
        }
    }
    
    
    func downloadImage(imageRef: String,completion: @escaping((Image?) -> ())) {
        
        var urlString = "\(baseImageURL)?maxwidth=\(maxThumbnailWidth)&photoreference=\(imageRef)&key=\(apiKey)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        Alamofire.request(URL(string: urlString)!).responseImage { response in
            if let image = response.result.value {
                completion(image)
            } else {
                completion(nil)
            }
            
        }
        
    }
    
    
    
}
