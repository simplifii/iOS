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

    var addressFormTableViewController: AddressFormTableViewController!

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
            addressFormTableViewController = segue.destination as? AddressFormTableViewController
            addressFormTableViewController?.orderModelController = orderModelController
        }
    }
    
    @IBAction func viewOrderSummary(_ sender: UIButton) {
        let zipcode = addressFormTableViewController.zipcodeTextField.text!
        if zipcode.isEmpty {
            self.showAlertMessage(title: "Zipcode is mandatory", message: nil)
            return
        }
        
        let addressLineOne = addressFormTableViewController.addressTextField.text!
        let addressLineTwo = addressFormTableViewController.addressLineTwoTextField.text!
        let address = Address(addressLineOne: addressLineOne, addressLineTwo: addressLineTwo, zipcode: zipcode)
        orderModelController.address = address
        orderModelController.entryNote = addressFormTableViewController.entryNotesTextView.text!
        
        APIService.getZipcodeServiceabilityInfo(zipcode: zipcode, completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                if data.count > 0 {
                    self.showOrderSummaryScreen()
                } else {
                    self.showErrorMessageScreen()
                }
            }
        })
    }
    
    
    func showErrorMessageScreen() {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "ErrorMessageViewController") as? ErrorMessageViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func showOrderSummaryScreen() {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "OrderSummaryViewController") as? OrderSummaryViewController
        vc?.orderModelController = orderModelController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}