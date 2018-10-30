//
//  OrderSummaryViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 03/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderSummaryViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var navbarView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var cartItems:[CartItem] = []
    var cartItemsCount = 0
    var totalItemsCount = 0
    var costPerMeal = 12
    
    var orderModelController: OrderModelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCartInfo()
        
        self.view.backgroundColor = Constants.backgroundColor
        
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 9.0        
    }
    
    func setCartInfo() {
        cartItems = orderModelController.cartItems
        cartItemsCount = cartItems.count
        for cartItem in cartItems {
            totalItemsCount = totalItemsCount + cartItem.quantity
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count + 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == cartItemsCount) || (indexPath.row == (cartItemsCount + 6)) || (indexPath.row == (cartItemsCount + 4)) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LineSeparatorTableViewCell") as! LineSeparatorTableViewCell
            return cell
        } else if indexPath.row == (cartItemsCount + 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubtotalTableViewCell") as! SubtotalTableViewCell
            
            let originalTotal = totalItemsCount * costPerMeal
            var finalTotal = totalItemsCount * costPerMeal - orderModelController.credits
            if finalTotal < 0 {
                finalTotal = 0
            }
            
            orderModelController.totalAmount = finalTotal
            
            cell.setSubtotal(originalSubtotal: originalTotal, finalSubtotal: finalTotal, credits: orderModelController.credits)
            return cell
        } else if indexPath.row == (cartItemsCount + 5) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell") as! AddressTableViewCell
            
            let address = "\(orderModelController.address.addressLineOne) \(orderModelController.address.addressLineTwo) \(orderModelController.address.zipcode)"
            cell.addressLabel.text = address
            cell.editButton.addTarget(self, action: #selector(self.showAddressScreen(_:)), for: UIControlEvents.touchUpInside)
            
            let icon = UIImage(named: "edit")!
            cell.editButton.setImage(icon, for: .normal)
            cell.editButton.imageView?.contentMode = .scaleAspectFit
            cell.editButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: -40)
            cell.editButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0)
            
            return cell
        } else if indexPath.row == (cartItemsCount + 7) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryDateTableViewCell") as! DeliveryDateTableViewCell
            
            // cell.deliveryDateLabel.text = "Sun 8/15 (8-10 AM)"
            cell.deliveryDateLabel.text = orderModelController.deliveryDateFormatted
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemTableViewCell") as! OrderItemTableViewCell
            
            if indexPath.row <= (cartItemsCount - 1) {
                cell.itemNameLabel.text = cartItems[indexPath.row].name
                cell.itemQtyLabel.text = "\(cartItems[indexPath.row].quantity)"
                
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
        } else if indexPath.row == (cartItemsCount + 5) {
            return 80
        } else if (indexPath.row == cartItemsCount) || (indexPath.row == (cartItemsCount + 6)) || (indexPath.row == (cartItemsCount + 4)) {
            return 24
        }
        return 34
    }

    
    
    @objc func showAddressScreen(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func proceedToPayment(_ sender: UIButton) {
        var meals:[[String:Any]] = []
        for cartItem in orderModelController.cartItems {
            meals.append(cartItem.mealInfo)
        }

        APIService.placeNewOrder(
            addressLineOne: orderModelController.address.addressLineOne,
            addressLineTwo: orderModelController.address.addressLineTwo,
            note: orderModelController.entryNote,
            deliverySlot: "Sun 10-12",
            zipcode: orderModelController.address.zipcode,
            deliveryDateFrom: orderModelController.deliveryDateFrom,
            deliveryDateTo: orderModelController.deliveryDateTo,
            meals: meals,
            completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.setCardData(data: data)
                self.showNextScreen()
            }
        })
    }
    
    func setCardData(data: JSON) {
        orderModelController.orderCardId = data[0]["id"].stringValue
        orderModelController.orderCardUniqueCode = data[0]["unique_code"].stringValue
    }
    
    func showNextScreen() {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController
        vc?.orderModelController = orderModelController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
