//
//  MealsViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 26/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class MealsViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var recipesContainerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = Constants.backgroundColor
        
        // update segment control appearance
       UISegmentedControl.appearance().setTitleTextAttributes([
        NSAttributedStringKey.foregroundColor: UIColor.lightGray,
        ], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: Constants.schemeColor,
            ], for: .selected)
        UISegmentedControl.appearance().tintColor = UIColor.white
        segmentedControl.layer.borderColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0).cgColor
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.cornerRadius = 3.0
        segmentedControl.backgroundColor = Constants.backgroundColor
        
        
        // Shadow
        segmentedControl.layer.shadowOpacity = 0.2
        segmentedControl.layer.shadowColor = UIColor.lightGray.cgColor
        segmentedControl.layer.shadowRadius = 8.0
        segmentedControl.layer.shadowOffset = CGSize.zero
        segmentedControl.layer.shadowPath =
            UIBezierPath(roundedRect: segmentedControl.bounds,
                         cornerRadius: segmentedControl.layer.cornerRadius).cgPath
        
    }
    
    @IBAction func showContainerView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.menuContainerView.alpha = 1
                self.recipesContainerView.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.menuContainerView.alpha = 0
                self.recipesContainerView.alpha = 1
            })
        }
    }
    
    @IBAction func goBackToPreviousScreen(_ sender: UIButton) {
    }
    
    @IBAction func showSettingsScreen(_ sender: UIButton) {
    }
}
