//
//  MenuViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 26/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON
import AlamofireImage

class MenuViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, MenuItemTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cartContainerView: UIView!
    
    var cartBarView: CartBarView!
    
    @IBOutlet weak var tableViewBottomDistanceConstaint: NSLayoutConstraint!
    
    var orderModelController = OrderModelController()
    
    var mealsJSON:JSON = []
    var cartItemsQty:Dictionary = [String: Int]()
    var cartItems:[CartItem] = []
    var totalItemsCount = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMeals()
        
        cartBarView = Bundle.main.loadNibNamed("CartBarView", owner: self, options: nil)?.first as? CartBarView
        cartBarView.frame.size = cartContainerView.bounds.size
        cartContainerView.addSubview(cartBarView!)
            cartBarView.cartCheckoutButton.addTarget(self, action: #selector(self.proceedToCheckout(_:)), for: UIControlEvents.touchUpInside)
        
        
        self.view.backgroundColor = Constants.backgroundColor
        
        tableView.dataSource = self
        tableView.delegate = self
        
        cartContainerView.isHidden = true
    }
    
    
    @objc func proceedToCheckout(_ sender: UIButton) {
        if getTotalItemsInCart() < 10 {
            showAlertMessage(title: "Minimum 10 items are required in cart to place the order", message: nil)
            return
        }
        
        addItemsInCart()
        
        cartContainerView.isHidden = true
        tableViewBottomDistanceConstaint.constant = 0
        
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "OrderConfirmationViewController") as? OrderConfirmationViewController
        vc?.orderModelController = orderModelController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func getTotalItemsInCart()->Int {
        var totalQuantity = 0
        for (_, qty) in cartItemsQty {
            totalQuantity = totalQuantity + qty
        }
        return totalQuantity
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsJSON.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell") as! MenuItemTableViewCell
        cell.menuItemTableViewCellDelegate = self
        
        cell.itemNameLabel.text = mealsJSON[indexPath.row]["title"].stringValue
        cell.itemIdentifier = "\(indexPath.row)"
        
        if mealsJSON[indexPath.row]["photo"] != JSON.null {
            let url = URL(string: mealsJSON[indexPath.row]["photo"].stringValue)!
            cell.itemImageView.af_setImage(withURL: url)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    
    
    func didTapAddButtonInside(cell: MenuItemTableViewCell) {
        cartItemsQty[cell.itemIdentifier] = cell.quantity
        if showCartBar() {
            setCartBarInfo()
            cartContainerView.isHidden = false
            tableViewBottomDistanceConstaint.constant = -cartContainerView.bounds.height
        } else {
            cartContainerView.isHidden = true
            tableViewBottomDistanceConstaint.constant = 0
        }
    }
    
    func setCartBarInfo() {
        var totalQuantity = 0
        for (_, qty) in cartItemsQty {
            totalQuantity = totalQuantity + qty
        }
        totalItemsCount = totalQuantity

        cartBarView.mealsInCartLabel.text = "Meals: \(totalItemsCount)"
        
        let minimumOrder = (10-totalItemsCount < 0) ? 0 : (10-totalItemsCount)
        cartBarView.descriptionLabel.text = "Add \(minimumOrder) more for minimum order of 10."
    }
    
    func showCartBar()->Bool {
        for (_, qty) in cartItemsQty {
            if qty > 0 {
                return true
            }
        }
        
        return false
    }
    
    
    func getMeals() {
        APIService.getMealsMenu(completion: {success, msg, data in
            if success {
                self.mealsJSON = data
                self.tableView.reloadData()
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    func addItemsInCart() {
        cartItems = []
        for (identifier, qty) in cartItemsQty {
            if qty > 0 {
                let index = Int(identifier)!
                if mealsJSON[index] != JSON.null {
                    let mealInfo:[String:Any] = [
                        "title": mealsJSON[index]["title"].stringValue,
                        "description": mealsJSON[index]["description"].stringValue,
                        "photo": mealsJSON[index]["photo"].stringValue,
                        "vegan_title": mealsJSON[index]["vegan_title"].stringValue,
                        "vegan_description": mealsJSON[index]["vegan_description"].stringValue,
                        "tags": mealsJSON[index]["tags"].stringValue,
                        "items": mealsJSON[index]["items"].stringValue,
                        "carbs": mealsJSON[index]["carbs"].intValue,
                        "protein": mealsJSON[index]["protein"].intValue,
                        "fat": mealsJSON[index]["fat"].intValue,
                        "calorie": mealsJSON[index]["calorie"].intValue,
                        "vegan_option_available": mealsJSON[index]["vegan_option_available"].intValue,
                        "scaling_factor": mealsJSON[index]["scaling_factor"].floatValue,
                        "quantity": qty
                    ]
                    cartItems.append(CartItem(
                        name: mealsJSON[index]["title"].stringValue,
                        quantity: qty,
                        mealInfo: mealInfo
                    ))
                }
            }
        }
        orderModelController.cartItems = cartItems
    }
}
