//
//  PaymentViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 03/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class PaymentViewController: BaseViewController {
    
    @IBOutlet weak var navbarView: UIView!

    var orderModelController: OrderModelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Constants.backgroundColor
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PaymentFormTableViewController
        {
            let vc = segue.destination as? PaymentFormTableViewController
            vc?.orderModelController = self.orderModelController
        }
    }
}
