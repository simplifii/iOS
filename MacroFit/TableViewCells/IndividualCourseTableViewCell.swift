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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
