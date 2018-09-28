//
//  MenuItemTableViewCell.swift
//  MacroFit
//
//  Created by Chandresh Singh on 26/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

@objc protocol MenuItemTableViewCellDelegate {
    func didTapAddButtonInside(cell: MenuItemTableViewCell)
}

class MenuItemTableViewCell: UITableViewCell, AddItemViewDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var addItemContainerView: UIView!
    
    var itemIdentifier = String()
    
    weak var menuItemTableViewCellDelegate: MenuItemTableViewCellDelegate?
    var quantity = Int()
    func itemQuantity(count: Int) {
        quantity = count
        if menuItemTableViewCellDelegate != nil {
            menuItemTableViewCellDelegate!.didTapAddButtonInside(cell: self)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellView()
    }
    
    func setupCellView() {
        itemNameLabel.numberOfLines = 2
        itemNameLabel.sizeToFit()
        
        containerView.layer.cornerRadius = 6.0
        
        // Rounder Corners
        let maskPath = UIBezierPath(roundedRect: itemImageView.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: 8.0, height: 8.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        itemImageView.layer.mask = shape
        
        // Add Item Button
        let addItemView = Bundle.main.loadNibNamed("AddItemView", owner: self, options: nil)?.first as? AddItemView
        addItemView!.frame.size = addItemContainerView.bounds.size
        addItemContainerView.addSubview(addItemView!)
        
        // Shadow
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowRadius = 5.0
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowPath =
            UIBezierPath(roundedRect: containerView.bounds,
                         cornerRadius: containerView.layer.cornerRadius).cgPath
        
        addItemView?.addItemViewDelegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
