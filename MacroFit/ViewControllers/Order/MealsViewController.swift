//
//  MealsViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 26/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class MealsViewController: UIViewController, DeliveryOverEmbeddedVCDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var recipesContainerView: UIView!
    @IBOutlet weak var deliveryOverContainerView: UIView!
    
    var deliveryOverEmbeddedVC:DeliveryOverEmbeddedViewController!
    var isOpen:Bool = true
    var openingDate:String = ""
    var days:String = ""
    var hours:String = ""
    var minutes:String = ""
    
    var showRecipe = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOrderPlacementDetails()
        
        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = Constants.backgroundColor
        
        // update segment control appearance
       UISegmentedControl.appearance().setTitleTextAttributes([
        NSAttributedStringKey.foregroundColor: UIColor.lightGray,
        ], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: Constants.schemeColor,
            ], for: .selected)
        UISegmentedControl.appearance().tintColor = UIColor.white
        segmentedControl.layer.borderColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0).cgColor
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.cornerRadius = 3.0
        segmentedControl.backgroundColor = Constants.backgroundColor
        
        
        // Shadow
        segmentedControl.layer.shadowOpacity = 0.2
        segmentedControl.layer.shadowColor = UIColor.lightGray.cgColor
        segmentedControl.layer.shadowRadius = 8.0
        segmentedControl.layer.shadowOffset = CGSize.zero
        segmentedControl.layer.shadowPath =
            UIBezierPath(roundedRect: segmentedControl.bounds,
                         cornerRadius: segmentedControl.layer.cornerRadius).cgPath
        
        
        showRecipe = (tabBarController as! TabBarViewController).showRecipeInMeals
        
        // Show recipe view
        deliveryOverContainerView.alpha = 0
        if showRecipe {
            segmentedControl.selectedSegmentIndex = 1
            showSelectedSegmentView(index: 1)
        }
        

    }
    
    @IBAction func showContainerView(_ sender: UISegmentedControl) {
        showSelectedSegmentView(index: sender.selectedSegmentIndex)
    }
    
    func showSelectedSegmentView(index:Int) {
        if index == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.recipesContainerView.alpha = 0
                
                if self.isOpen == false {
                    self.showDeliveryOverScreen()
                } else {
                    self.menuContainerView.alpha = 1
                    self.deliveryOverContainerView.alpha = 0
                }
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.menuContainerView.alpha = 0
                self.deliveryOverContainerView.alpha = 0
                self.recipesContainerView.alpha = 1
            })
        }
    }
    
    
    
    func getOrderPlacementDetails() {
        APIService.getOrderPlacementDetails(completion: {success, msg, data in
            self.isOpen = data["is_open"].boolValue
            self.openingDate = data["next_opening_date"].stringValue;
            self.days =  data["datetime"]["days"].stringValue;
            self.hours = data["datetime"]["hours"].stringValue;
            self.minutes = data["datetime"]["minutes"].stringValue;
            
            if self.isOpen == false {
                if self.showRecipe == false {
                    self.showDeliveryOverScreen()
                } else {
                    self.showRecipe = false
                }
            }
        })
    }
    
    func showDeliveryOverScreen() {
        self.menuContainerView.alpha = 0
        self.recipesContainerView.alpha = 0
        self.deliveryOverContainerView.alpha = 1
        
        deliveryOverEmbeddedVC.openingDate = openingDate
        deliveryOverEmbeddedVC.days = days
        deliveryOverEmbeddedVC.hours = hours
        deliveryOverEmbeddedVC.minutes = minutes
        deliveryOverEmbeddedVC.setData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DeliveryOverEmbeddedViewController
        {
            deliveryOverEmbeddedVC = segue.destination as? DeliveryOverEmbeddedViewController
            deliveryOverEmbeddedVC.deliveryOverEmbeddedVCDelegate = self
        }
    }
    
    func showRecipeContainerView() {
        segmentedControl.selectedSegmentIndex = 1
        showSelectedSegmentView(index: 1)
    }
    
    func showRecipeView() {
        showRecipeContainerView()
    }
    
}
