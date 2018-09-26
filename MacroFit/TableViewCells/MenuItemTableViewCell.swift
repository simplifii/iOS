//
//  MenuItemTableViewCell.swift
//  MacroFit
//
//  Created by Chandresh Singh on 26/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var addItemContainerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellView()
    }
    
    func setupCellView() {
        containerView.layer.cornerRadius = 8.0
        
        let maskPath = UIBezierPath(roundedRect: itemImageView.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: 8.0, height: 8.0))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        itemImageView.layer.mask = shape
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
