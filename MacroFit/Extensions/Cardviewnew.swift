//
//  Cardviewnew.swift
//  MacroFit
//
//  Created by Sachin Arora on 16/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//
import Foundation
import UIKit

class Cardviewnew: UIView {

    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Float = 0.1
    @IBInspectable var shadowColor: UIColor? = UIColor.lightGray.withAlphaComponent(0.6)
    @IBInspectable var shadowOpacity: Float = 0.4
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: Int(shadowOffsetHeight));
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }

}
