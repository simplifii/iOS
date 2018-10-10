//
//  RoundedCornerBoxView.swift
//  MacroFit
//
//  Created by Chandresh Singh on 19/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class RoundedCornerBoxView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = 9.0
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.cornerRadius = self.layer.cornerRadius
        gradient.colors = [UIColor.white.cgColor, UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0).cgColor]
        self.layer.insertSublayer(gradient, at: 0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowPath =
            UIBezierPath(roundedRect: self.bounds,
                         cornerRadius: self.layer.cornerRadius).cgPath
    }
}
