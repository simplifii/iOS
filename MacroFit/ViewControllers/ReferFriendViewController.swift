//
//  ReferFriendViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 18/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class ReferFriendViewController: BaseViewController {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var creditsLeftLabel: UILabel!
    
    var userUniqueCode = ""
    var gift = "$25"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserCredits()

        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)

    }
    
    
    @IBAction func inviteFriends(_ sender: UIButton) {
        let text = "Hey, have you used MacroFit? You can save on your next order. Use my code \(userUniqueCode) to get an extra \(gift) off on your next order"
        
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func setUserCredits() {
        APIService.getUserProfile(completion: {success,msg,data in
            if success == true {
                self.setCreditsLeftLabel(credits: data[0]["credits"].intValue)
                self.userUniqueCode =  data[0]["unique_code"].stringValue
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    func setCreditsLeftLabel(credits: Int) {
        creditsLeftLabel.text = "You have \(credits) credits"
    }
}
