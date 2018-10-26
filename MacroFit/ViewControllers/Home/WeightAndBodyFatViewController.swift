//
//  WeightAndBodyFatViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 26/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class WeightAndBodyFatViewController: BaseViewController {
    
    @IBOutlet weak var navbarView: UIView!

    var weightAndBodyFatFormTableVC: WeightAndBodyFatFormTableViewController!
    
    var weight:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackNavbarInView(navbarView: navbarView, settings_visible: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is WeightAndBodyFatFormTableViewController {
            weightAndBodyFatFormTableVC = segue.destination  as? WeightAndBodyFatFormTableViewController
            weightAndBodyFatFormTableVC.weight = weight
        }
    }

    @IBAction func submitWeightAndBodyFat(_ sender: UIButton) {
        let (success,msg) = validateFields()
        if success == false {
            self.showAlertMessage(title: msg!, message: nil)
            return
        }
        updateWeightAndBodyFat()
    }
    
    func validateFields()->(Bool,String?) {
        let weight = weightAndBodyFatFormTableVC.weightTextField.text!
        let bodyFat = weightAndBodyFatFormTableVC.bodyFatTextField.text!
        if weight.isEmpty {

            return (false,"Weight is required")
        }
        if bodyFat.isEmpty {
            return (false,"Body Fat is required")
        }
        return (true, nil)
    }
    
    func updateWeightAndBodyFat() {
        let bodyFat = Int(weightAndBodyFatFormTableVC.bodyFatTextField.text!)!

        APIService.updateBodyFat(bodyFat: bodyFat, completion: {success,msg in
            if success == true {
                self.showPreviousScreen()
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
}
