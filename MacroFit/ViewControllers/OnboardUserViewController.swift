//
//  OnboardUserViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 18/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class OnboardUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func addBackNavbarInView(navbarView: UIView) {
        if let backNavbarView = Bundle.main.loadNibNamed("BackNavbarView", owner: self, options: nil)?.first as? BackNavbarView {
            navbarView.addSubview(backNavbarView)
            backNavbarView.frame.size.width = self.view.bounds.size.width
            
            backNavbarView.backButton.addTarget(self, action: #selector(self.goBackToPreviousScreen(_:)), for: UIControlEvents.touchUpInside)
            
        }
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
            progressBarXIBView.frame.size.width = self.view.bounds.size.width
        }
    }
    
    @objc func goBackToPreviousScreen(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }

    
    public func showAlertMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        action.setValue(Constants.schemeColor, forKey: "titleTextColor")
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}
