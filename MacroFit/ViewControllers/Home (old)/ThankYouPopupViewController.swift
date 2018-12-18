//
//  ThankYouPopupViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 25/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class ThankYouPopupViewController: FeedbackPopupBaseViewController {

    @IBOutlet weak var containerView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 8.0
        
        showAnimate()        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        removeAnimate()
    }
}
