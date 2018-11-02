//
//  PasswordchangeViewController.swift
//  MacroFit
//
//  Created by devendra kumar on 02/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class PasswordchangeViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var Successunsuccess: UILabel!
    var tempmessage:String = ""
    var tempSuccessunsuccess = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.text = tempmessage
        Successunsuccess.text = tempSuccessunsuccess
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ClosepopUp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
