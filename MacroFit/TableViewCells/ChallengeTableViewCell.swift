//
//  ChallengeTableViewCell.swift
//  MacroFit
//
//  Created by ajay dubedi on 25/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
   
    @IBOutlet weak var backgroundCardView: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        backgroundCardView.layer.cornerRadius = 8.0
        backgroundCardView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
