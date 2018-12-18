//
//  WorkoutChallengeTVC.swift
//  MacroFit
//
//  Created by mac on 12/14/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class WorkoutChallengeTVC: BaseTVC {

    var data:ChallengeModel!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var friends: UILabel!
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var freeOrPremium: UIButton!
    
    
    func setViews(){
        VCUtil.setImage(url: data.photo, imageView: bg)
        title.text = data.title
        tags.text = data.tags
        friends.text = data.friends
        setGradient()
    }
    
    override func displayData(model: BaseTableCell) {
        data = model as? ChallengeModel
        setViews()
        container.showShadow(offset: 0.5, opacity: 0.2)
    }
    
    func setGradient(){
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = bg.bounds
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientMaskLayer.locations = [0, 0.7]
        gradientMaskLayer.startPoint = CGPoint(x:0,y:0.5)
        gradientMaskLayer.endPoint = CGPoint(x:1,y:0.5)
        
        bg.layer.mask = gradientMaskLayer
    }
}
