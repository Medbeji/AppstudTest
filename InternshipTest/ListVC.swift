//
//  PlacesVC.swift
//  TestApp
//
//  Created by MedBeji on 16/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import UIKit
import GoogleMaps

class ListVC: UICollectionViewController {
    
    // Current Location Property
    var location: CLLocation?

    // Pull to refresh property
    let refresher = UIRefreshControl()

    
    // Cell id
    let cellId = "cellId"
    
    // Places
    var places: [Place]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        navigationItem.title = "List"
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(PlaceCell.self, forCellWithReuseIdentifier: cellId)
        pullToRefresh()
    }
    
    // Handle pullToRefresh functionnality
    func pullToRefresh(){
        refresher.backgroundColor = .white
        self.collectionView!.alwaysBounceVertical = true
        refresher.tintColor = UIColor.init(red: 58, green: 63, blue: 97, alpha: 1)
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView!.addSubview(refresher)
    }
    
    
    // loadData when we pull To Refresh
    func loadData(){
        var lat: Double?
        var long:  Double?
        
        if let _ = self.location {
            lat = self.location?.coordinate.latitude
            long = self.location?.coordinate.longitude
        } else {
            // Somewhere in Paris
            lat = 48.856967
            long = 2.329887
        }
        
        Service.sharedInstance.nearbyPlaces(latitude: lat!, longitude: long!) { (places) in
            self.places = places
        }
        
    }
    
}


extension ListVC : UICollectionViewDelegateFlowLayout {
    
    // Handle CollectionView Flow Layout delegate methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (places != nil ) ? places!.count : 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! PlaceCell
        if let places = places {
            cell.place = places[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    
    
    
}

