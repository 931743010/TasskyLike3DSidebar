//
//  HamburgerView.swift
//  Taasky
//
//  Created by wamaker on 15/7/14.
//  Copyright (c) 2015年 Ray Wenderlich. All rights reserved.
//

import UIKit

class HamburgerView: UIView {

    let imageView: UIImageView! = UIImageView(image: UIImage(named: "Hamburger"))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: Private
    
    private func configure() {
        imageView.contentMode = UIViewContentMode.Center
        addSubview(imageView)
    }
    
    func rotate(fraction: CGFloat) {
        let angle = Double(fraction) * M_PI_2
        imageView.transform = CGAffineTransformMakeRotation(CGFloat(angle))
    }

}
