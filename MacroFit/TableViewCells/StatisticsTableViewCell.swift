//
//  StatisticsTableViewCell.swift
//  MacroFit
//
//  Created by ajay dubedi on 30/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var userScoreUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
