//
//  OrderConfirmationViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 28/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderConfirmationViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var navbarView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonBottomDistanceConstraint: NSLayoutConstraint!
    
    
    
    var cartItems:[CartItem] = []
    var cartItemsCount = 0
    var totalItemsCount = 0
    var costPerMeal = 12
    var credits = 0
    let buttonBottomDistanceConstraintValue:CGFloat = 234
    
    var orderModelController:OrderModelController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserCreditsAndAddress()
        
        setCartInfo()
        
        self.view.backgroundColor = Constants.backgroundColor
        
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 9.0
        
        buttonBottomDistanceConstraint.constant = buttonBottomDistanceConstraintValue
    }
    
    func setCartInfo() {
        cartItems = orderModelController.cartItems
        cartItemsCount = cartItems.count
        for cartItem in cartItems {
            totalItemsCount = totalItemsCount + cartItem.quantity
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count + 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == cartItemsCount {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LineSeparatorTableViewCell") as! LineSeparatorTableViewCell
            return cell
        } else if indexPath.row == (cartItemsCount + 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubtotalTableViewCell") as! SubtotalTableViewCell
            
            let originalTotal = totalItemsCount * costPerMeal
            var finalTotal = totalItemsCount * costPerMeal - credits
            if finalTotal < 0 {
                finalTotal = 0
            }
            
            cell.setSubtotal(originalSubtotal: originalTotal, finalSubtotal: finalTotal, credits: credits)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemTableViewCell") as! OrderItemTableViewCell
            
            if indexPath.row <= (cartItemsCount - 1) {
                cell.itemNameLabel.text = cartItems[indexPath.row].name
                cell.itemQtyLabel.text = "\(cartItems[indexPath.row].quantity)"
                
                
                if buttonBottomDistanceConstraint.constant - 34 > 20 {
                    buttonBottomDistanceConstraint.constant = buttonBottomDistanceConstraint.constant - 34
                }
            } else if indexPath.row == (cartItemsCount + 1) {
                cell.itemNameLabel.text = "Meals"
                cell.itemNameLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
                
                cell.itemQtyLabel.text = "\(totalItemsCount)"
                cell.itemQtyLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
            } else if indexPath.row == (cartItemsCount + 2) {
                cell.itemNameLabel.text = "Cost per meal"
                cell.itemNameLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
                
                cell.itemQtyLabel.text = "$\(costPerMeal)"
                cell.itemQtyLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == (cartItemsCount + 3) {
            return 50
        }
        return 34
    }
    
    
    func setUserCreditsAndAddress() {
        APIService.getUserProfile(completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                if data[0]["credits"] != JSON.null {
                    self.credits = data[0]["credits"].intValue
                    self.orderModelController.credits = self.credits
                    
                    self.buttonBottomDistanceConstraint.constant = self.buttonBottomDistanceConstraintValue
                    self.tableView.reloadData()
                }
                
    
                let address = Address(
                    addressLineOne: data[0]["cdata"]["address_line_1"].stringValue,
                    addressLineTwo: data[0]["cdata"]["address_line_2"].stringValue,
                    zipcode: data[0]["zipcode"].stringValue
                )
                self.orderModelController.address = address
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddressViewController
        {
            let vc = segue.destination as? AddressViewController
            vc?.orderModelController = self.orderModelController
        }
    }
}
