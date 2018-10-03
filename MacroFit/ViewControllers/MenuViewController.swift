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

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MenuItemTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cartContainerView: UIView!
    @IBOutlet var cartBarView: UIView!
    @IBOutlet weak var mealsInCartLabel: UILabel!
    @IBOutlet weak var cartBarDescriptionLabel: UILabel!
    
    @IBOutlet weak var tableViewBottomDistanceConstaint: NSLayoutConstraint!
    
    var orderModelController = OrderModelController()
    
    var mealsJSON:JSON = []
    var cartItemsQty:Dictionary = [String: Int]()
    var cartItems:[CartItem] = []
    var totalItemsCount = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMeals()
        
        self.view.backgroundColor = Constants.backgroundColor
        
        tableView.dataSource = self
        tableView.delegate = self
        
        cartContainerView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cartBarView.frame.size = cartContainerView.bounds.size
        cartContainerView.addSubview(cartBarView)
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
    
    
    
    @IBAction func proceedToCheckout(_ sender: UIButton) {
        cartContainerView.isHidden = true
        tableViewBottomDistanceConstaint.constant = 0
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

        mealsInCartLabel.text = "Meals: \(totalItemsCount)"
        cartBarDescriptionLabel.text = "Add \(10-totalItemsCount) more for minimum order of 10. Add \(15-totalItemsCount) more to save 25% on cost/meal."
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
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "OrderConfirmationViewControllerSegue" {
            addItemsInCart()
            if cartItems.count == 0 {
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is OrderConfirmationViewController
        {
            let vc = segue.destination as? OrderConfirmationViewController
            vc?.orderModelController = orderModelController
        }
    }
}
