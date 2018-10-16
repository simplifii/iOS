//
//  PaymentFormTableViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 04/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import Stripe

class PaymentFormTableViewController: UITableViewController {
    
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expiryDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    
    var orderModelController: OrderModelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expiryDateTextField.addTarget(self, action: #selector(self.expiryDateTextFieldDidChange(_:)), for: .editingChanged)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    @IBAction func continuePayment(_ sender: UIButton) {
        let (success, msg) = validateFields()
        if success == false {
            showAlertMessage(title: msg, message: nil)
            return
        }
        
        let (month, year) = getMonthAndYearFrom(expiryDate: expiryDateTextField.text!)
        
        let cardParams = STPCardParams()
        cardParams.number = cardNumberTextField.text!
        cardParams.expMonth = month
        cardParams.expYear = year
        cardParams.cvc = cvvTextField.text!

        sender.isEnabled = false
        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
//                self.showAlertMessage(title: "Unable to complete transaction", message: error?.localizedDescription)
                sender.isEnabled = true
                self.showErrorScreen()
                return
            }

            self.completePayment(stripeToken: token.tokenId, sender: sender)
        }
    }
    
    func completePayment(stripeToken: String, sender: UIButton) {
        let amount = orderModelController.totalAmount * 100 // Amount in cents
        let orderId = orderModelController.orderCardId
        let orderCardUniqueCode = orderModelController.orderCardUniqueCode
        let credits = orderModelController.credits * 100 // Amount in cents
        
        APIService.orderPayment(
            stripeToken: stripeToken,
            amount: amount,
            orderId: orderId,
            orderCardUniqueCode: orderCardUniqueCode,
            credits: credits,
            completion: {success,msg in
                sender.isEnabled = true
                
                if success == false {
                    self.showAlertMessage(title: msg, message: nil)
                } else {
                    self.showSuccessScreen()
                }
        })
        print(stripeToken)
    }
    
    func validateFields()->(Bool, String) {
        let cardNumber = cardNumberTextField.text!
        let expiryDate = expiryDateTextField.text!
        let cvv = cvvTextField.text!
        
        if cardNumber.isEmpty {
            return (false, "Card number is required")
        }
        if expiryDate.isEmpty {
            return (false, "Expiry date is required")
        }
        if cvv.isEmpty {
            return (false, "CVV is required")
        }
        
        
        if cardNumber.count < 14 || cardNumber.count > 19 {
            return (false, "Card number should lie between 14 to 19 digits")
        }
        if expiryDate.count != 5 {
            return (false, "Please enter expiry date in MM/YY format")
        }
        let expiryDateComponents = expiryDate.components(separatedBy: "/")
        if expiryDateComponents.count != 2 || expiryDateComponents[1].isEmpty {
            return (false, "Please enter both month and year in expiry date")
        }
        
        let month = Int(expiryDateComponents[0])!
        let year = Int(expiryDateComponents[1])!
        if month < 1 || month > 12 || year < 1 || year > 999 {
            return (false, "Please enter correct expiry date")
        }
        
        if cvv.count != 3 && cvv.count != 4 {
            return (false, "CVV can either be 3 or 4 digit number")
        }
        
        return (true, "Success")
    }
    
    func getMonthAndYearFrom(expiryDate: String) -> (UInt,UInt) {
        let expiryDateComponents = expiryDate.components(separatedBy: "/")
        let month = UInt(expiryDateComponents[0])!
        let year = UInt(expiryDateComponents[1])!
        return (month, (2000 + year))
    }
    
    
    func showAlertMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        action.setValue(Constants.schemeColor, forKey: "titleTextColor")
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    
    @objc func expiryDateTextFieldDidChange(_ textField: UITextField) {
        if textField.text != "" {
            let date = textField.text!
            let count = date.count
            if count == 1 {
                if date != "0" && date != "1" {
                    textField.text = "0" + date + "/"
                }
            } else if count == 2 {
                if date[date.index(before: date.endIndex)] != "/" {
                    textField.text = date + "/"
                }
            }
        }
    }
    
    func showSuccessScreen() {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "OrderConfirmationSuccessViewController") as? OrderConfirmationSuccessViewController
        vc?.orderModelController  = orderModelController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func showErrorScreen() {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "PaymentErrorViewController") as? PaymentErrorViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
