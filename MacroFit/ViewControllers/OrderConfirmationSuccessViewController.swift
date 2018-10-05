//
//  OrderConfirmationSuccessViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 05/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class OrderConfirmationSuccessViewController: UIViewController {

    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var freeGiftlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
        
        // Remove all previous screen for setting new root view controller
        self.navigationController?.viewControllers.removeAll()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func learnMore(_ sender: UIButton) {
    }
    
}
