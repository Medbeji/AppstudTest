//
//  CustomMarker.swift
//  InternshipTest
//
//  Created by MedBeji on 17/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import GoogleMaps


class CustomMarker: GMSMarker {
    
    // MARK: - Views
    let markerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    let frameView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 42, height: 42))
   
    // MARK: Transformation
    let shapeLayer = CAShapeLayer()
    let cornersToRound = UIRectCorner.topLeft.union(UIRectCorner.topRight.union(UIRectCorner.bottomRight))
    
    // MARK: - Init
    public override init() {
        super.init()
        
        
        self.setupViews()
        
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.iconView = markerView
        self.groundAnchor = CGPoint(x: 0, y: 1)
    }
    
    public convenience init(position: CLLocationCoordinate2D) {
        self.init()
        self.position = position
    }
    
    
    private func setupViews() {
     
        // Setup Main Shape to match the same marker view frame
        shapeLayer.bounds = markerView.frame
        shapeLayer.position = markerView.center
        
        // Black round shape
        let pointerRadius = CGSize(width: shapeLayer.frame.width / 2, height: shapeLayer.frame.width / 2)
        shapeLayer.path = UIBezierPath(roundedRect: markerView.frame, byRoundingCorners: cornersToRound, cornerRadii: pointerRadius).cgPath
        markerView.layer.mask = shapeLayer
        
        // Setup Round Shapes
        frameView.layer.cornerRadius = frameView.frame.width / 2
        imageView.layer.cornerRadius = imageView.frame.width / 2
        
        // Change colors 
        markerView.backgroundColor = UIColor(red: 248/255, green: 148/255, blue: 6/255, alpha: 0.5)
        frameView.backgroundColor = UIColor.black
        imageView.backgroundColor = UIColor.white
        
        // Change the position of the ImageView to be at the center of the Marker frame
        imageView.center = frameView.center
        
        // Add the image to Frame
        frameView.addSubview(imageView)
        
        // Add the FrameView to the markerView subviews
        markerView.addSubview(frameView)
    }
    
}
