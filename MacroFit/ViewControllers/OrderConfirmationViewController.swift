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
        
        buttonBottomDistanceConstraint.constant = 234
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
            }  else if indexPath.row == (cartItemsCount + 3) {
                cell.itemNameLabel.text = "Subtotal"
                cell.itemNameLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
                
                cell.itemQtyLabel.text = "$\(totalItemsCount * costPerMeal)"
                cell.itemQtyLabel.font = UIFont.boldSystemFont(ofSize: 19.0)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 34
    }
    
    
    @IBAction func confirmOrder(_ sender: UIButton) {
    }
}
