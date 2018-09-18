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
        self.addBackNavbarInView(navbarView: navbarView)
        self.addProgressBarInView(progressBarView: progressBarView, percent: 40, description: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
