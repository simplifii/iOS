//
//  AddressViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 01/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class AddressViewController: BaseViewController {
    
    @IBOutlet weak var navbarView: UIView!

    var orderModelController: OrderModelController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: true)

    }
    
    
    // TODO::validate fields

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddressFormTableViewController
        {
            let vc = segue.destination as? AddressFormTableViewController
            vc?.orderModelController = orderModelController
        } else if segue.destination is OrderSummaryViewController
        {
            let vc = segue.destination as? OrderSummaryViewController
            vc?.orderModelController = orderModelController
        }
    }
}
