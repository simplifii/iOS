//
//  ReceivedCreditViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 25/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class ReceivedCreditViewController: UIViewController {

    @IBOutlet weak var receivedCreditTextLabel: UILabel!
    
    var credits = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        receivedCreditTextLabel.text = "You've received $\(credits) in credit."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
