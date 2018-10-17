//
//  WhiteRoundedCornerBoxView.swift
//  MacroFit
//
//  Created by Chandresh Singh on 17/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class WhiteRoundedCornerBoxView: UIView {
    
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
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowPath =
            UIBezierPath(roundedRect: self.bounds,
                         cornerRadius: self.layer.cornerRadius).cgPath
    }
}
