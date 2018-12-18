//
//  UIImageView.swift
//  DISC
//
//  Created by mac on 11/17/18.
//  Copyright © 2018 DISC. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // Image tint color fix
    override open func awakeFromNib() {
        super.awakeFromNib()
        tintColorDidChange()
    }
}
