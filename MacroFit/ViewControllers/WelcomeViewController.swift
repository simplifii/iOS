//
//  WelcomeViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 25/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

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
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func getOrderPlacementDetails() {
        APIService.getOrderPlacementDetails(completion: {success, msg, data in
            self.ordrePlacementDayLabel.text = "\(data["from_day"].stringValue) - \(data["to_day"].stringValue)"
            self.ordrePlacementTimeLabel.text = "until \(data["closing_time"].stringValue)."
            self.remainingTimeLabel.text = data["time_left"].stringValue
        })
    }
}
