//
//  DietaryPreferencesViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 24/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class DietaryPreferencesViewController: OnboardUserViewController, UITextViewDelegate {
    
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var progressBarView: UIView!

    @IBOutlet weak var dietaryOptionsView: UIView!
    var dietaryOptions = ["Paleo", "Vegetarian", "Vegan", "Keto"]
    var selectedDietaryOpition = "Paleo"
    
    @IBOutlet weak var additionalDietaryPreferencesTextView: UITextView!
    var diet_note = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: true)
        self.addProgressBarInView(progressBarView: progressBarView, percent: 80, description: "Customizing your Macros")
        addDietaryOptionsInView()
        
        additionalDietaryPreferencesTextView.layer.borderColor = UIColor.lightGray.cgColor;
        additionalDietaryPreferencesTextView.layer.borderWidth = 1.0;
        additionalDietaryPreferencesTextView.layer.cornerRadius = 15.0;
        additionalDietaryPreferencesTextView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addDietaryOptionsInView() {
        var y_position = 0
        for (index, option) in dietaryOptions.enumerated() {
            let button = UIButton(frame: CGRect(x: 0, y: y_position, width: Int(dietaryOptionsView.frame.width) , height: 35))
            button.backgroundColor = .white
            button.cornerRadius = 15
            button.borderWidth = 1
            button.borderColor = UIColor.lightGray
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitle(option, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.contentHorizontalAlignment = .left
            button.titleEdgeInsets = UIEdgeInsets()
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            button.addTarget(self, action: #selector(self.selectDietaryPreference(_:)), for: UIControlEvents.touchUpInside)
            button.tag = index + 1
            
            if option == selectedDietaryOpition {
                selectedButtonView(button: button)
            }
            
            dietaryOptionsView.addSubview(button)
            
            y_position = y_position + 42
        }
    }
    
    @objc func selectDietaryPreference(_ sender: UIButton) {
        for (index, _) in dietaryOptions.enumerated() {
            if let button = self.view.viewWithTag(index + 1) as? UIButton {
                defaultButtonView(button: button)
            }
        }
        
        selectedButtonView(button: sender)
        selectedDietaryOpition = sender.currentTitle!
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
    }
    
    func textViewDidChange(_ textView: UITextView) {
        diet_note = textView.text
    }

    func defaultButtonView(button: UIButton) {
        button.backgroundColor = .white
        button.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    func selectedButtonView(button: UIButton) {
        button.backgroundColor = UIColor(red: 255/255, green: 200/255, blue: 187/255, alpha: 1.0)
        button.setTitleColor(UIColor(red: 255/255, green: 59/255, blue: 0.0, alpha: 1.0), for: .normal)
    }
    
    
    @IBAction func updateDietaryPreferences(_ sender: UIButton) {
        APIService.updateDietaryPreferences(dietary_preference: selectedDietaryOpition, diet_note: diet_note, completion: {success,msg in
            if success {                
                self.gotoNextScreen()
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    func gotoNextScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
