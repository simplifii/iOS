//
//  OnboardUserViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 18/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class OnboardUserViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func addProgressBarInView(progressBarView: UIView, percent: Int, description: String?) {
        if let progressBarXIBView = Bundle.main.loadNibNamed("ProgressBarView", owner: self, options: nil)?.first as? ProgressBarView {
            progressBarView.addSubview(progressBarXIBView)
            if (percent > 20) && (percent <= 40) {
                progressBarXIBView.progressBarImage.image = UIImage(named: "progress_bar_40_percent")
            } else if (percent > 40) && (percent <= 60) {
                progressBarXIBView.progressBarImage.image = UIImage(named: "progress_bar_60_percent")
            } else if (percent > 60) && (percent <= 80) {
                progressBarXIBView.progressBarImage.image = UIImage(named: "progress_bar_80_percent")
            }
            progressBarXIBView.progressPercentageLabel.text = "\(percent)%"
            if description != nil {
                progressBarXIBView.descriptionLabel.text = description
            }
            progressBarXIBView.frame.size.width = progressBarView.bounds.size.width
        }
    }
}
