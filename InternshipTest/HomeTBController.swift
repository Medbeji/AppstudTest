//
//  HomeTBController.swift
//  TestApp
//
//  Created by MedBeji on 16/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import UIKit

class HomeTBController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()        
    }
    
    fileprivate func setupControllers() {
        // Setup Controller 1
        let vc1 = MapVC()
        let mapNavigationController = UINavigationController(rootViewController: vc1)
        mapNavigationController.title = "Map"
        mapNavigationController.tabBarItem.image = UIImage(named: "map")
        
        // Setup Controller 2
        let vc2 = PlacesVC()
        let listNavigationController = UINavigationController(rootViewController: vc2)
        listNavigationController.title = "List"
        listNavigationController.tabBarItem.image = UIImage(named: "list")
        
        // Add the 2 controllers to viewController attribute
        viewControllers = [mapNavigationController,listNavigationController]
    }
    
}


