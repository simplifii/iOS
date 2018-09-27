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
    
    var mealsJSON:JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMeals()
        
        self.view.backgroundColor = Constants.backgroundColor
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableViewBottomDistanceConstaint.constant = -cartContainerView.bounds.height
        
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
        print(cell.quantity)
    }
    
    
    func getMeals() {
        APIService.getMealsMenu(completion: {success, msg, data in
            print(data)
            if success {
                self.mealsJSON = data
                self.tableView.reloadData()
            }
        })
    }
}
