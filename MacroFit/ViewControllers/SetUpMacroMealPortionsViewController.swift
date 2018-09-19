//
//  SetUpMacroMealPortionsViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 19/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var customPercentMacrosForSnacksTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        self.addBackNavbarInView(navbarView: navbarView)
        self.addProgressBarInView(progressBarView: progressBarView, percent: 60, description: "Customizing your Macros")
        
        
//        roundLeftCorners(button: twoMealsPerDayButton, cornerRadius: 10.0)
//        roundRightCorners(button: fiveMealsPerDayButton, cornerRadius: 10.0)
        
        
        customPercentMacrosForSnacksTextField.layer.borderWidth = 1.0
        customPercentMacrosForSnacksTextField.layer.borderColor = UIColor.lightGray.cgColor
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
    
    func selectMacrosPercentageInSnacks(sender: UIButton) {
        for button in [zeroPercentMacrosForSnacksButton, fivePercentMacrosForSnacksButton, tenPercentMacrosForSnacksButton] {
            defaultButtonUI(button: button!)
        }
        
        selectedButtonUI(button: sender)
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
    

}
