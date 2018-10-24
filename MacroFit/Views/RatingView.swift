//
//  RatingView.swift
//  MacroFit
//
//  Created by Chandresh Singh on 24/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit


class RatingView: UIView {

    @IBOutlet weak var starOneImageView: UIImageView!
    @IBOutlet weak var startTwoImageView: UIImageView!
    @IBOutlet weak var starThreeImageView: UIImageView!
    @IBOutlet weak var starFourImageView: UIImageView!
    @IBOutlet weak var starFiveImageView: UIImageView!
    

    public func setRating(rating: Int){
        let image = UIImage(named: "star_orange_full.png")
        
        var numberOfStars = rating
        for imageView in [starOneImageView, startTwoImageView, starThreeImageView, starFourImageView, starFiveImageView] {
            if numberOfStars <= 0 {
                break
            }
            imageView!.image = image
            numberOfStars -= 1
        }
    }

}
