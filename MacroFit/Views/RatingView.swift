//
//  RatingView.swift
//  MacroFit
//
//  Created by Chandresh Singh on 24/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit


class RatingView: UIView {

    @IBOutlet weak var starOneButton: UIButton!
    @IBOutlet weak var startTwoButton: UIButton!
    @IBOutlet weak var starThreeButton: UIButton!
    @IBOutlet weak var starFourButton: UIButton!
    @IBOutlet weak var starFiveButton: UIButton!
    
    
    override func awakeFromNib() {
        viewSetup()
    }
    
    func viewSetup() {
        starOneButton.accessibilityHint = "1"
        startTwoButton.accessibilityHint = "2"
        starThreeButton.accessibilityHint = "3"
        starFourButton.accessibilityHint = "4"
        starFiveButton.accessibilityHint = "5"
    }
    
    
    public func setRating(rating: Int){
        setDefaultImage()
        
        let image = UIImage(named: "star_orange_full.png")
        
        var numberOfStars = rating
        for button in [starOneButton, startTwoButton, starThreeButton, starFourButton, starFiveButton] {
            if numberOfStars <= 0 {
                break
            }
            button?.setImage(image, for: .normal)
            numberOfStars -= 1
        }
    }
    
    func setDefaultImage() {
        let image = UIImage(named: "star_gray.png")
        for button in [starOneButton, startTwoButton, starThreeButton, starFourButton, starFiveButton] {
            button?.setImage(image, for: .normal)
        }
    }

}
