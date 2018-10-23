//
//  HomeViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 23/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: BaseViewController {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var fatWeightLabel: UILabel!
    @IBOutlet weak var fatWeightUnitLabel: UILabel!
    
    @IBOutlet weak var bodyFatNotEnteredLabel: UILabel!
    
    var userProfile:JSON = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserMacrosData()

        addMenuNavbarInView(navbarView: navbarView)
        
        // setupSegmentedControlView()
    }
    
    func setupSegmentedControlView() {
        UISegmentedControl.appearance().setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "Montserrat", size: 10)!,
            ], for: .normal)
        segmentedControl.layer.borderColor = Constants.schemeColor.cgColor
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.cornerRadius = 3.0
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.frame = CGRect(x: segmentedControl.frame.minX, y: segmentedControl.frame.minY, width: segmentedControl.frame.width, height: 20)
    }
    
    
    func setUserMacrosData() {
        APIService.getUserProfile(completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.userProfile = data[0]
                self.setUpMacrosData()
            }
        })
    }
    
    func setUpMacrosData() {
        setPerMealData()
        
        weightLabel.text = userProfile["weight"].stringValue
        
        let bodyFat = userProfile["cdata"]["body_fat"].stringValue
        if bodyFat.isEmpty {
            bodyFatNotEnteredLabel.isHidden = false
            
            fatWeightLabel.isHidden = true
            fatWeightUnitLabel.isHidden = true
        } else {
            bodyFatNotEnteredLabel.isHidden = true
            
            fatWeightLabel.isHidden = false
            fatWeightUnitLabel.isHidden = false
            
            fatWeightLabel.text = bodyFat
        }
    }
    
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        if userProfile.count > 0 {
            if segmentedControl.selectedSegmentIndex == 0 {
                setPerMealData()
            } else {
                caloriesLabel.text = userProfile["cdata"]["calories_per_day"].stringValue
                carbsLabel.text = "\(userProfile["cdata"]["carbs_per_day"].intValue)g"
                proteinLabel.text = "\(userProfile["cdata"]["protein_per_day"].intValue)g"
                fatLabel.text = "\(userProfile["cdata"]["fat_per_day"].intValue)g"
            }
        }
    }
    
    func setPerMealData() {
        caloriesLabel.text = userProfile["calories"].stringValue
        carbsLabel.text = "\(userProfile["carbs"].intValue)g"
        proteinLabel.text = "\(userProfile["protein"].intValue)g"
        fatLabel.text = "\(userProfile["fat"].intValue)g"
    }
}
