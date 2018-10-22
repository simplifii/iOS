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
    
    var orderModelController: OrderModelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deliveryDateLabel.text = orderModelController.deliveryDateFormatted
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
        
        self.navigationController?.viewControllers.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    @IBAction func learnMore(_ sender: UIButton) {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "ReferFriendViewController") as? ReferFriendViewController
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
