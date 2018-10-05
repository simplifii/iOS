//
//  PaymentErrorViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 05/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class PaymentErrorViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goBackToPayment(_ sender: UIButton) {
        self.showPreviousScreen()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.showPreviousScreen()
    }
}
