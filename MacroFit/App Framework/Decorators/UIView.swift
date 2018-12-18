//
//  UIView.swift
//  MacroFit
//
//  Created by mac on 12/14/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

extension UIView{
    
    func showShadow(offset:CGFloat, opacity: Float){
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSize(width: 0, height: offset)
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = shadowPath.cgPath
    }
    
}
