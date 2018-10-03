//
//  DeliveryDateTableViewCell.swift
//  MacroFit
//
//  Created by Chandresh Singh on 03/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class DeliveryDateTableViewCell: UITableViewCell {

    @IBOutlet weak var deliveryDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Sun 8/15 (8-10 AM)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
