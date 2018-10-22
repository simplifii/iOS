//
//  BasicInfoViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 18/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class BasicInfoViewController: OnboardUserViewController {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
    
        self.addProgressBarInView(progressBarView: progressBarView, percent: 40, description: nil)

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
