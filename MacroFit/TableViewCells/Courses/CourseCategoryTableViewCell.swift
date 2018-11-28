//
//  CourseTableViewCell.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/19/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class CourseCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundImageView?.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
