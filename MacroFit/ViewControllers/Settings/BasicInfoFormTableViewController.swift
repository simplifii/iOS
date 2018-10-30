//
//  BasicInfoFormTableViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 18/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON
import DropDown

class BasicInfoFormTableViewController: UITableViewController, UITextViewDelegate {

    @IBOutlet weak var fitnessGoalsView: UIView!
    
    @IBOutlet weak var ageTextFIeld: UITextField!
    @IBOutlet weak var weightTextFIeld: UITextField!
    @IBOutlet weak var feetTextFIeld: UITextField!
    @IBOutlet weak var inchesTextFIeld: UITextField!
    @IBOutlet weak var genderSelectionButton: UIButton!
    var genderDropDown = DropDown()
    var genderOptions = ["Male", "Female"]
    
    
    @IBOutlet weak var activityLevelSlider: UISlider!
    @IBOutlet weak var selectedActivityTitleTextField: UILabel!
    @IBOutlet weak var selectedActivityDescriptionTextField: UILabel!
    @IBOutlet weak var selectedActivityCaloriesInfoTextField: UILabel!
    var activityLevels: JSON = []
    
    
    var goals:[String] = []
    var selectedGoal = String()
    @IBOutlet weak var fitnessGoalNoteTextView: UITextView!
    
    var userProfile:JSON = [:]
    
    
    // Fields
    var age  = String()
    var weight  = String()
    var height  = String()
    var goalNote  = String()
    var activityLevel  = String()
    var gender = String()
    var per_day_cal_burn = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()

        fitnessGoalNoteTextView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareView() {
        for state: UIControlState in [.normal, .selected, .application, .reserved, .focused] {
            activityLevelSlider.setThumbImage(UIImage(named: "slider_thumb"), for: state)
        }
        
        genderDropDown.anchorView = genderSelectionButton
        genderDropDown.dataSource = genderOptions
        genderDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.genderSelectionButton.setTitle(item, for: .normal)
            self.genderSelectionButton.setTitleColor(UIColor.black, for: .normal)
        }
        
        fitnessGoalNoteTextView.layer.borderColor = UIColor.lightGray.cgColor;
        fitnessGoalNoteTextView.layer.borderWidth = 1.0;
        fitnessGoalNoteTextView.layer.cornerRadius = 15.0;
        
        setActivityLevels()
        setFitnessGoals()
    }
    
    private func addFitnessGoalOptionsInView() {
        var y_position = 0
        for (index, goal) in goals.enumerated() {
            let button = UIButton(frame: CGRect(x: 0, y: y_position, width: Int(fitnessGoalsView.frame.width) , height: 35))
            button.backgroundColor = .white
            button.cornerRadius = 15
            button.borderWidth = 1
            button.borderColor = UIColor.lightGray
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitle(goal, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.contentHorizontalAlignment = .left
            button.titleEdgeInsets = UIEdgeInsets()
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            button.addTarget(self, action: #selector(self.selectFitnessGoal(_:)), for: UIControlEvents.touchUpInside)
            button.tag = index + 1
            
            fitnessGoalsView.addSubview(button)
            
            y_position = y_position + 42
        }
    }
    
    @objc func selectFitnessGoal(_ sender: UIButton) {
        for (index, _) in goals.enumerated() {
            if let button = self.view.viewWithTag(index + 1) as? UIButton {
                button.backgroundColor = .white
                button.setTitleColor(UIColor.lightGray, for: .normal)
            }
        }
        
        sender.backgroundColor = UIColor(red: 255/255, green: 200/255, blue: 187/255, alpha: 1.0)
        sender.setTitleColor(UIColor(red: 255/255, green: 59/255, blue: 0.0, alpha: 1.0), for: .normal)
        selectedGoal = sender.currentTitle!
    }

    func setActivityLevels() {
        APIService.activityLevels(completion: {success, msg, data in
            self.activityLevels = data
            self.setActivitySliderValues()
            self.tableView.reloadData()
        })
    }
    
    func setActivitySliderValues() {
        if activityLevels.count > 0 {
            selectedActivityTitleTextField.tag = -1
            
            setActivityInfoInView(sliderValue: 100)
            
            activityLevelSlider.maximumValue = 3000
            activityLevelSlider.minimumValue = 50
            activityLevelSlider.value = 100
        }
    }
    
    func setFitnessGoals() {
        APIService.fitnessGoals(completion: {success, msg, data in
            for (_, goal_obj) in data {
                self.goals.append(goal_obj["label"].stringValue)
            }
            self.addFitnessGoalOptionsInView()
            self.tableView.reloadData()
            
            self.getUserProfile()
        })
    }
    
    
    @IBAction func setActivity(_ sender: UISlider) {
        if Int(sender.value) < 50 {
            sender.setValue(50, animated: true)
        }
        
        setActivityInfoInView(sliderValue: Int(sender.value))
    }
    
    func setActivityInfoInView(sliderValue: Int) {
        for (index,activity) in activityLevels {
            if (sliderValue >= activity["low_range"].intValue) && (sliderValue <= activity["high_range"].intValue) {
                if selectedActivityTitleTextField.tag != Int(index)! {
                    
                    selectedActivityTitleTextField.tag = Int(index)!
                    
                    selectedActivityTitleTextField.text = activity["title"].stringValue
                    selectedActivityDescriptionTextField.text = activity["description"].stringValue
                    
                    let caloriesBurned = "\(activity["low_range"].stringValue)-\(activity["high_range"].stringValue) Calories Burned Daily"
                    selectedActivityCaloriesInfoTextField.text = caloriesBurned
                    
                    per_day_cal_burn = "\(sliderValue)"
                }
            }
        }
    }
    
    
    @IBAction func updateCustomerDetails(_ sender: UIButton) {
        setFieldsData()
        let (success, msg) = validateFields()
        if success == true {
            print("validated")
            APIService.updateCustomerBasicDetails(age: age, weight: weight, height: height, activity_level: activityLevel, goal: selectedGoal, gender: gender, per_day_cal_burn: per_day_cal_burn, goal_note: goalNote, completion: {success, msg in
                if success == true {
                    self.gotoNextScreen()
                } else {
                    self.showAlertMessage(title: msg, message: nil)
                }
            })
        } else {
            showAlertMessage(title: msg, message: nil)
        }
    }
    
    func gotoNextScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetUpMacroMealPortionsViewController") as? SetUpMacroMealPortionsViewController
        vc?.userProfile = userProfile
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func setFieldsData() {
        age = ageTextFIeld.text!
        weight = weightTextFIeld.text!
        
        if feetTextFIeld.text != "" {
            if inchesTextFIeld.text != "" {
                height = "\((12 * Int(feetTextFIeld.text!)!) + Int(inchesTextFIeld.text!)!)"
            } else {
                height = "\((12 * Int(feetTextFIeld.text!)!))"
            }
        }
        gender = genderSelectionButton.currentTitle!
        activityLevel = selectedActivityTitleTextField.text ?? ""
    }
    
    func validateFields() -> (Bool, String) {
        if age.isEmpty {
            return (false, "Age is required")
        }
        if weight.isEmpty {
            return (false, "Weight is required")
        }
        if height.isEmpty {
            return (false, "Height is required in feet and inches")
        }
        if gender.isEmpty || (gender == "Gender") {
            return (false, "Gender is required")
        }
        
        return (true, "Success")
    }
    
    func showAlertMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        action.setValue(Constants.schemeColor, forKey: "titleTextColor")
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Anything else to tell us about your fitness goals or how we can help?"
        } else {
            goalNote = textView.text
        }
    }
    
    @IBAction func showGenderDropDown(_ sender: UIButton) {
        genderDropDown.show()
    }
    
    func getUserProfile() {
        APIService.getUserProfile(completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.userProfile = data[0]
                self.setUserProfileData()
            }
        })
    }
    
    func setUserProfileData() {
        ageTextFIeld.text = self.userProfile["age"].stringValue
        weightTextFIeld.text = self.userProfile["weight"].stringValue
        let height = self.userProfile["height"].intValue
        if height > 0 {
            let heightInFeet = Int(height / 12)
            feetTextFIeld.text = "\(heightInFeet)"
            inchesTextFIeld.text = "\(Int(height) - (heightInFeet*12))"
        }
        
        if self.userProfile["gender_bool"] != JSON.null {
            let isMale = self.userProfile["gender_bool"].boolValue
            if isMale {
                self.genderSelectionButton.setTitle("Male", for: .normal)
                self.genderSelectionButton.setTitleColor(UIColor.black, for: .normal)
            } else {
                self.genderSelectionButton.setTitle("Female", for: .normal)
                self.genderSelectionButton.setTitleColor(UIColor.black, for: .normal)
            }
        }
        
        if self.userProfile["activity_level"] != JSON.null {
            let activityLevel = self.userProfile["activity_level"].stringValue
            for (_,activity) in activityLevels {
                if activityLevel == activity["title"].stringValue {
                    let value = Int((activity["low_range"].intValue + activity["high_range"].intValue)/2)
                    setActivityInfoInView(sliderValue: value)
                    activityLevelSlider.setValue(Float(value), animated: true)
                }
            }
        }
        
        if self.userProfile["goal"] != JSON.null {
            let goal = self.userProfile["goal"].stringValue
            for (index, goalValue) in goals.enumerated() {
                if goal == goalValue {
                    if let button = fitnessGoalsView.viewWithTag(index + 1) as? UIButton {
                        button.backgroundColor = UIColor(red: 255/255, green: 200/255, blue: 187/255, alpha: 1.0)
                        button.setTitleColor(Constants.schemeColor, for: .normal)
                        selectedGoal = button.currentTitle!
                    }
                }
            }
        }
        
        if !self.userProfile["goal_note"].stringValue.isEmpty {
            fitnessGoalNoteTextView.text = self.userProfile["goal_note"].stringValue
        }
    }
    
}
