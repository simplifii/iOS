//
//  SetUpMacroMealPortionsViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 19/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class SetUpMacroMealPortionsViewController: OnboardUserViewController {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    
    @IBOutlet weak var mealsSelectionView: RoundedCornerBoxView!
    
    @IBOutlet weak var twoMealsPerDayButton: UIButton!
    @IBOutlet weak var threeMealsPerDayButton: UIButton!
    @IBOutlet weak var fourMealsPerDayButton: UIButton!
    @IBOutlet weak var fiveMealsPerDayButton: UIButton!
    var selectedNoOfMeals = String()
    
    @IBOutlet weak var zeroPercentMacrosForSnacksButton: UIButton!
    @IBOutlet weak var fivePercentMacrosForSnacksButton: UIButton!
    @IBOutlet weak var tenPercentMacrosForSnacksButton: UIButton!
    @IBOutlet weak var twentyPercentMacrosForSnacksButton: UIButton!
    
    var macrosPercentageInSnacks = String()
    
    var userProfile:JSON = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        prefillValues()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
        self.addProgressBarInView(progressBarView: progressBarView, percent: 60, description: "Customizing your Macros")

        
//        roundLeftCorners(button: twoMealsPerDayButton, cornerRadius: 10.0)
//        roundRightCorners(button: fiveMealsPerDayButton, cornerRadius: 10.0)
        
        selectedButtonUI(button: threeMealsPerDayButton)
        selectedNoOfMeals = threeMealsPerDayButton.currentTitle!
        
        selectedButtonUI(button: zeroPercentMacrosForSnacksButton)
        setMacrosPercentageInSnacks(percentage: zeroPercentMacrosForSnacksButton.currentTitle!)
    }
    
    func prefillValues() {
        if userProfile["meals_per_day"] != JSON.null {
            switch userProfile["meals_per_day"].intValue {
            case 2:
                selectMealsPerDay(sender: twoMealsPerDayButton)
                break
            case 3:
                selectMealsPerDay(sender: threeMealsPerDayButton)
                break
            case 4:
                selectMealsPerDay(sender: fourMealsPerDayButton)
                break
            case 5:
                selectMealsPerDay(sender: fiveMealsPerDayButton)
                break
            default:
                break
            }
        }
        
        if userProfile["cdata"]["snacks"] != JSON.null {
            let snacksPercentage = userProfile["cdata"]["snacks"].intValue
            switch snacksPercentage {
                case 0:
                    selectMacrosPercentageInSnacks(sender: zeroPercentMacrosForSnacksButton)
                    break
                case 5:
                    selectMacrosPercentageInSnacks(sender: fivePercentMacrosForSnacksButton)
                    break
                case 10:
                    selectMacrosPercentageInSnacks(sender: tenPercentMacrosForSnacksButton)
                    break
                case 20:
                    selectMacrosPercentageInSnacks(sender: twentyPercentMacrosForSnacksButton)
                    break
                default:
                    break
            }
        }
    }
    
    func roundLeftCorners(button: UIButton, cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: button.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        maskLayerWithPath(button: button, path: path)
    }
    
    func roundRightCorners(button: UIButton, cornerRadius: Double) {
        let path = UIBezierPath(roundedRect: button.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        maskLayerWithPath(button: button, path: path)
    }
    
    func maskLayerWithPath(button: UIButton, path: UIBezierPath) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        button.layer.mask = maskLayer
    }
    
    // START: Select Meals Per Day
    @IBAction func selectTwoMealsPerDay(_ sender: UIButton) {
        selectMealsPerDay(sender: sender)
    }
    @IBAction func selectThreeMealsPerDay(_ sender: UIButton) {
        selectMealsPerDay(sender: sender)
    }
    @IBAction func selectFourMealsPerDay(_ sender: UIButton) {
        selectMealsPerDay(sender: sender)
    }
    @IBAction func selectFiveMealsPerDay(_ sender: UIButton) {
        selectMealsPerDay(sender: sender)
    }
    
    func selectMealsPerDay(sender: UIButton) {
        for button in [twoMealsPerDayButton, threeMealsPerDayButton, fourMealsPerDayButton, fiveMealsPerDayButton] {
            defaultButtonUI(button: button!)
        }
        
        selectedButtonUI(button: sender)
        selectedNoOfMeals = sender.currentTitle!
    }
    // END: Select Meals Per Day
    
    
    // START: Select Macros Percentage In Snacks
    @IBAction func selectZeroPercentMacrosInSnacks(_ sender: UIButton) {
        selectMacrosPercentageInSnacks(sender: sender)
    }
    @IBAction func selectFivePercentMacrosInSnacks(_ sender: UIButton) {
        selectMacrosPercentageInSnacks(sender: sender)
    }
    @IBAction func selectTenPercentMacrosInSnacks(_ sender: UIButton) {
        selectMacrosPercentageInSnacks(sender: sender)
    }
    @IBAction func selectTwentyPercentMacrosInSnacks(_ sender: UIButton) {
        selectMacrosPercentageInSnacks(sender: sender)
    }
    
    func selectMacrosPercentageInSnacks(sender: UIButton) {
        for button in [zeroPercentMacrosForSnacksButton, fivePercentMacrosForSnacksButton, tenPercentMacrosForSnacksButton, twentyPercentMacrosForSnacksButton] {
            defaultButtonUI(button: button!)
        }
        
        selectedButtonUI(button: sender)
        setMacrosPercentageInSnacks(percentage: sender.currentTitle!)
    }
    // END: Select Macros Percentage In Snacks
    

    
    func defaultButtonUI(button: UIButton) {
        button.backgroundColor = .clear
        button.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    func selectedButtonUI(button: UIButton) {
        button.backgroundColor = UIColor(red: 255/255, green: 200/255, blue: 187/255, alpha: 1.0)
        button.setTitleColor(UIColor(red: 255/255, green: 59/255, blue: 0.0, alpha: 1.0), for: .normal)
    }
    
    @IBAction func setUpMacroMealPortions(_ sender: UIButton) {
        APIService.updateCustomerRecommendedMacros(meals_per_day: selectedNoOfMeals, snacks: macrosPercentageInSnacks, completion: {success,msg in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.showNextScreen()
            }
        })
    }
    
    func showNextScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecommendedDailyMacrosViewController") as? RecommendedDailyMacrosViewController
        vc?.userProfile = userProfile
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func setMacrosPercentageInSnacks(percentage: String) {
        macrosPercentageInSnacks = percentage.replacingOccurrences(of: "%", with: "")
    }
    
}
