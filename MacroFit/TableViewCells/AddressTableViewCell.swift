//
//  AddressTableViewCell.swift
//  MacroFit
//
//  Created by Chandresh Singh on 03/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeEditButton()
    }
    
    func customizeEditButton() {
        editButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        editButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        editButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
