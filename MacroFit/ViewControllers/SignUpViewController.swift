//
//  SignUpViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 17/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class SignUpViewController: OnboardUserViewController {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackNavbarInView(navbarView: navbarView)
        self.addProgressBarInView(progressBarView: progressBarView, percent: 20, description: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
