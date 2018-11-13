//
//  YogaCoursesTableViewCell.swift
//  MacroFit
//
//  Created by Sachin Arora on 13/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class YogaCoursesTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var CoursePrice: UILabel!
    @IBOutlet weak var YogaExcersiseimage: UIImageView!
    @IBOutlet weak var YogatagName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
         setupCellView()
        // Initialization code
    }
    func setupCellView() {
//        itemNameLabel.numberOfLines = 2
//        itemNameLabel.sizeToFit()
        
        containerView.layer.cornerRadius = 6.0
        
        // Rounder Corners
        let maskPath = UIBezierPath(roundedRect: YogaExcersiseimage.bounds,
                                    byRoundingCorners: [.topLeft, .bottomLeft],
                                    cornerRadii: CGSize(width: 8.0, height: 8.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        YogaExcersiseimage.layer.mask = shape
        
//        // Add Item Button
//        let addItemView = Bundle.main.loadNibNamed("AddItemView", owner: self, options: nil)?.first as? AddItemView
//        addItemView!.frame.size = addItemContainerView.bounds.size
//        addItemContainerView.addSubview(addItemView!)
        
        // Shadow
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowRadius = 5.0
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowPath =
            UIBezierPath(roundedRect: containerView.bounds,
                         cornerRadius: containerView.layer.cornerRadius).cgPath
        
//        addItemView?.addItemViewDelegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
