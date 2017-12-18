//
//  PlaceCell.swift
//  InternshipTest
//
//  Created by MedBeji on 17/12/2017.
//  Copyright © 2017 Appstud. All rights reserved.
//

import UIKit

class PlaceCell: UICollectionViewCell {
    
    var place: Place? {
        didSet {
            if let place = place {
                if  let imageRef = place.photo_reference {
                    Service.sharedInstance.downloadImage(imageRef: imageRef , completion: { (image) in
                        if let image = image {
                            self.imageView.image = image
                        }
                    })
                }
                self.title.text = place.name
            }
        }
    }
    
    
    
    let visualEffect: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7
        return view
    }()
    
    let imageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let blurVisualEffect: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.text = "Sample title"
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 16)
        title.textColor = UIColor.init(red: 223, green: 215, blue: 215, alpha: 0.8)
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        
        // Add  Elements to view
        addSubview(imageView)
        imageView.addSubview(visualEffect)
        addSubview(blurVisualEffect)
        blurVisualEffect.addSubview(title)
        
        // Autolayouts
        imageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        visualEffect.anchor(imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        blurVisualEffect.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        title.anchor(blurVisualEffect.topAnchor, left: blurVisualEffect.leftAnchor , bottom: blurVisualEffect.bottomAnchor, right: blurVisualEffect.rightAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    
}
