//
//  ProfileViewController.swift
//  MacroFit
//
//  Created by devendra kumar on 02/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
//                StoryBoard.tempmessage = "You have Successfully change your password"
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
            StoryBoard.tempSuccessunsuccess = "UnSuccess"
            StoryBoard.tempmessage = "Please enter the password"
            self.present(StoryBoard, animated: false, completion: nil)
        }
    }
    
    
}
