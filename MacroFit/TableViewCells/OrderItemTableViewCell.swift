//
//  OrderItemTableViewCell.swift
//  MacroFit
//
//  Created by Chandresh Singh on 28/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class OrderItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemQtyLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
