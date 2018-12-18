//
//  IndividualCourseTableViewCell.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/20/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class IndividualCourseTableViewCell: UITableViewCell {
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 5
    }
}
