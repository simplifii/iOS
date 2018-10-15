//
//  WelcomeViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 25/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {

    @IBOutlet weak var ordrePlacementDayLabel: UILabel!
    @IBOutlet weak var ordrePlacementTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        getOrderPlacementDetails()
//        ordrePlacementDayLabel.text = "Mon - Thur"
//        ordrePlacementTimeLabel.text = "until 8:00 pm PST."
//        remainingTimeLabel.text = "1 Day 16 Hrs 32 Min"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        viewNextScreen()
    }
    
    @IBAction func showNextScreen(_ sender: UIButton) {
        viewNextScreen()
    }
    
    func viewNextScreen() {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func getOrderPlacementDetails() {
        APIService.getOrderPlacementDetails(completion: {success, msg, data in
            if success == true {
                if data["is_open"].boolValue == true {
                    self.ordrePlacementDayLabel.text = "\(data["from_day"].stringValue) - \(data["to_day"].stringValue)"
                    self.ordrePlacementTimeLabel.text = "until \(data["closing_time"].stringValue)."
                    self.remainingTimeLabel.text = data["time_left"].stringValue
                } else {
                    self.viewDeliveryOverScreen(
                        date: data["next_opening_date"].stringValue,
                        days: data["datetime"]["days"].stringValue,
                        hours: data["datetime"]["hours"].stringValue,
                        minutes: data["datetime"]["minutes"].stringValue
                    )
                }
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    func viewDeliveryOverScreen(date:String, days:String, hours:String, minutes:String) {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "DeliveryOverViewController") as? DeliveryOverViewController
        vc?.openingDate = date
        vc?.days = days
        vc?.hours = hours
        vc?.minutes = minutes
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
