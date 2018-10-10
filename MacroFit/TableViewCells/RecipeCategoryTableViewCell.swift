//
//  RecipeCategoryTableViewCell.swift
//  MacroFit
//
//  Created by Chandresh Singh on 10/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class RecipeCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var blackOverlayView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        backgroundImageView.layer.cornerRadius = 6.0
        blackOverlayView.layer.cornerRadius = 6.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
