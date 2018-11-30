//
//  SignUpOptionsViewController.swift
//  MacroFit
//
//  Created by Chandresh on 29/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class SignUpOptionsViewController: SignUpBaseViewController {

    @IBOutlet weak var expiryTimeLabel: UILabel!
    var expiryTimeInSeconds = 180
    var gameTimer: Timer!
    
    @IBOutlet weak var signUpWithFBButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setExipryTimer()
        
        addFacebookIconInButton(button: signUpWithFBButton)
    }
    
    func setExipryTimer() {
        gameTimer =   Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateExpiryTime(_:)), userInfo: nil, repeats: true)
        gameTimer.fire()

    }
    
    @objc func updateExpiryTime(_ sender: Timer) {        
        if expiryTimeInSeconds < 0 {
            gameTimer.invalidate()
            return
        }
        let minutes = expiryTimeInSeconds/60
        let seconds = expiryTimeInSeconds - (minutes*60)
        if seconds < 10 {
            expiryTimeLabel.text = "\(minutes):0\(seconds)"
        } else {
            expiryTimeLabel.text = "\(minutes):\(seconds)"
        }
        expiryTimeInSeconds -= 1
    }

    @IBAction func loginUsingFacebook(_ sender: UIButton) {
        loginWithFacebook()
    }
    
    
    @IBAction func goBack(_ sender: UIButton) {
        self.showPreviousScreen()
    }
    

    @IBAction func signUpAsTrainer(_ sender: UIButton) {
    }
}
