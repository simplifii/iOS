//
//  ProfileViewController.swift
//  MacroFit
//
//  Created by devendra kumar on 02/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var navbarView: UIView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
        
        userNameLabel.text = UserDefaults.standard.string(forKey: UserConstants.userName)
        userEmailLabel.text = UserDefaults.standard.string(forKey: UserConstants.userEmail)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Savechangebutton(_ sender: UIButton) {
        let password1 = newPassword!
        let password2 = repeatPassword!
        
        if ((password1.text != "") && password2.text != ""){
            if (password1.text == password2.text)
            {
//
//                let StoryBoard = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "PasswordchangeViewController") as! PasswordchangeViewController
//
//                StoryBoard.tempSuccessunsuccess = "Success"
//                StoryBoard.tempmessage = "You have Successfully changed your password"
//
                newPassword.text = ""
                repeatPassword.text = ""
//                self.present(StoryBoard, animated: false, completion: nil)
            }
            else{
                
                let StoryBoard = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "PasswordchangeViewController") as! PasswordchangeViewController
                StoryBoard.tempSuccessunsuccess = "Couldn't Save"
                StoryBoard.tempmessage = "Passwords do not match!"
                self.present(StoryBoard, animated: false, completion: nil)
            }
        }
        else
        {
            
            let StoryBoard = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "PasswordchangeViewController") as! PasswordchangeViewController
            StoryBoard.tempSuccessunsuccess = "Couldn't Save"
            StoryBoard.tempmessage = "Please enter the new password"
            self.present(StoryBoard, animated: false, completion: nil)
        }
    }
    
    
}
