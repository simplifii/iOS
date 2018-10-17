//
//  ErrorMessageViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 04/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class ErrorMessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func cancel(_ sender: UIButton) {
        self.showPreviousScreen()
    }
    
    @IBAction func okay(_ sender: UIButton) {
        self.showPreviousScreen()
    }
    
}
