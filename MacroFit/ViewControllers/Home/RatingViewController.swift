//
//  RatingViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 25/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

@objc protocol ThankYouPopupDelegate {
    func showThankPopup()
}

class RatingViewController: FeedbackPopupBaseViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ratingContainerView: UIView!
    
    var thankYouPopupDelegate: ThankYouPopupDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 8.0
        addRatingView()
        
        showAnimate()        
    }
    
    func addRatingView() {
        let ratingView = Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)?.first as? RatingView
        ratingView!.frame.size.height = ratingContainerView.bounds.size.height
        
        ratingView!.center = CGPoint(x: (containerView.frame.size.width/2)+10,
                                     y: ratingContainerView.frame.size.height / 2)
        
        ratingContainerView.addSubview(ratingView!)
        ratingView!.setRating(rating: 5)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        removeAnimate()
    }
    @IBAction func sendFeedback(_ sender: UIButton) {
        thankYouPopupDelegate.showThankPopup()
        
        removeAnimate()
    }
}
