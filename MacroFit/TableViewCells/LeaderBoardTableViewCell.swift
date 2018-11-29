//
//  LeaderBoardTableViewCell.swift
//  MacroFit
//
//  Created by ajay dubedi on 31/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class LeaderBoardTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
