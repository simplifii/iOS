//
//  SettingProfileTableViewCell.swift
//  MacroFit
//
//  Created by devendra kumar on 02/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class SettingProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var names: UILabel!
    @IBOutlet weak var images: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
