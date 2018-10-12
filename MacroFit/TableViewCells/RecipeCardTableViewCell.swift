//
//  RecipeCardTableViewCell.swift
//  MacroFit
//
//  Created by Chandresh Singh on 11/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

@objc protocol RecipeCardTableViewCellDelegate {
    func markRecipeFavourite(cell: RecipeCardTableViewCell)
}


class RecipeCardTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var recipeCardTableViewCellDelegate: RecipeCardTableViewCellDelegate!
    
    var recipeId:String!
    var isFavourite:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCellView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCellView() {
        containerView.layer.cornerRadius = 6.0
        
        // Rounder Corners
        let maskPath = UIBezierPath(roundedRect: recipeImageView.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width: 8.0, height: 8.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        recipeImageView.layer.mask = shape
        

        // Shadow
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowRadius = 5.0
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowPath =
            UIBezierPath(roundedRect: containerView.bounds,
                         cornerRadius: containerView.layer.cornerRadius).cgPath
    }
    
    func markFavourite() {
        isFavourite = true
        setFavouriteButtonImage()
    }
    
    func setFavouriteButtonImage() {
        if isFavourite == true {
            if let image = UIImage(named: "heart_full.png") {
                favouriteButton.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(named: "heart_orange.png") {
                favouriteButton.setImage(image, for: .normal)
            }
        }
    }
    
    
    @IBAction func markFavourite(_ sender: UIButton) {
        recipeCardTableViewCellDelegate.markRecipeFavourite(cell: self)
    }
    
}
