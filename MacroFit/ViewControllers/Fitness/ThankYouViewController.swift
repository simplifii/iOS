//
//  ThankYouViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 23/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class ThankYouViewController: BaseViewController {

    var action:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        showPreviousScreen()
    }
    
    @IBAction func okayAction(_ sender: UIButton) {
        showPreviousScreen()
    }
    
    
    func showUserInterest() {
        APIService.userInterestInFitness(action: action, completion: {success,msg in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
}
