//
//  WelcomeViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 25/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var ordrePlacementDayLabel: UILabel!
    @IBOutlet weak var ordrePlacementTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        ordrePlacementDayLabel.text = "Mon - Thur"
        ordrePlacementTimeLabel.text = "until 8:00 pm PST."
        remainingTimeLabel.text = "1 Day 16 Hrs 32 Min"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
