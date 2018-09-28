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
    @IBOutlet weak var roundedCornerBoxHeightConstraint: NSLayoutConstraint!
    
    
    var cartItems = [[String: String]]()
    var cartItemsCount = 0
    var totalItemsCount = 0
    var costPerMeal = 12
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCartInfo()
        
        self.view.backgroundColor = Constants.backgroundColor
        
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: true)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 9.0
        
    }
    
    func setCartInfo() {
        cartItemsCount = cartItems.count
        for cartItem in cartItems {
            totalItemsCount = totalItemsCount + Int(cartItem["qty"]!)!
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count + 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == cartItemsCount {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LineSeparatorTableViewCell") as! LineSeparatorTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemTableViewCell") as! OrderItemTableViewCell
            
            if indexPath.row <= (cartItemsCount - 1) {
                cell.itemNameLabel.text = cartItems[indexPath.row]["title"]
                cell.itemQtyLabel.text = cartItems[indexPath.row]["qty"]
            } else if indexPath.row == (cartItemsCount + 1) {
                cell.itemNameLabel.text = "Meals"
                cell.itemQtyLabel.text = "\(totalItemsCount)"
            } else if indexPath.row == (cartItemsCount + 2) {
                cell.itemNameLabel.text = "Cost per meal"
                cell.itemQtyLabel.text = "$\(costPerMeal)"
            }  else if indexPath.row == (cartItemsCount + 3) {
                cell.itemNameLabel.text = "Subtotal"
                cell.itemQtyLabel.text = "$\(totalItemsCount * costPerMeal)"
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    @IBAction func confirmOrder(_ sender: UIButton) {
    }
}
