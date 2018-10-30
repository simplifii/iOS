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
        getAndSetDeliveryDate()
        
        setupView()

        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupView() {
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)

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
        let addressLineOne = addressFormTableViewController.addressTextField.text!
        
        if zipcode.isEmpty {
            self.showAlertMessage(title: "Zipcode is required", message: nil)
            return
        }
        if addressLineOne.isEmpty {
            self.showAlertMessage(title: "Address is required", message: nil)
            return
        }
        
        let addressLineTwo = addressFormTableViewController.addressLineTwoTextField.text!
        let address = Address(addressLineOne: addressLineOne, addressLineTwo: addressLineTwo, zipcode: zipcode)
        orderModelController.address = address
        orderModelController.entryNote = addressFormTableViewController.entryNotesTextView.text!
        
        
        APIService.updateAddress(addressLineOne: addressLineOne, addressLineTwo:addressLineTwo, zipcode:zipcode, completion: {success,msg in
            if success == false {
                if msg == "This zipcode is not servicable" {
                    self.showErrorMessageScreen()
                } else {
                    self.showAlertMessage(title: msg, message: nil)
                }
            } else {
                if !self.orderModelController.deliveryDateFormatted.isEmpty {
                    self.showOrderSummaryScreen()
                } else {
                    self.showAlertMessage(title: "Unable to get delivery date", message: nil)
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
    
    func getAndSetDeliveryDate() {
        APIService.getDeliveryDate(completion: {success,msg,data in
            if success == true {
                self.orderModelController.deliveryDateFormatted = data["delivery_date"].stringValue
                self.orderModelController.deliveryDateFrom = data["from_timestamp"].stringValue
                self.orderModelController.deliveryDateTo = data["to_timestamp"].stringValue
            }  else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
}
