//
//  LoginViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 05/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class LoginViewController: OnboardUserViewController {

    @IBOutlet weak var navbarView: UIView!

    var email = String()
    var password = String()
    var showNavbar = false
    
    var loginFormTableViewController:LoginFormTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(showNavbar)
        if showNavbar {
            self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is LoginFormTableViewController
        {
            loginFormTableViewController = segue.destination as? LoginFormTableViewController
        }
    }
    
    
    func setFieldsData() {
        email = loginFormTableViewController.emailTextField.text!
        password = loginFormTableViewController.passwordTextField.text!
    }
    
    func validateFields() -> Bool {
        if (email.isEmpty) {
            showAlertMessage(title: "Email is required", message: nil)
            return false
        }
        
        if (password.isEmpty) {
            showAlertMessage(title: "Name is required", message: nil)
            return false
        }
        
        return true
    }
    
    @IBAction func loginUser(_ sender: UIButton) {
        setFieldsData()
        if validateFields() == false {
            return
        }
        callLoginAPI(sender: sender)
    }
    
    func callLoginAPI(sender: UIButton) {
        sender.isEnabled = false
        
        APIService.loginUser(username: self.email, password: self.password, completion: {success,msg in
            sender.isEnabled = true
            
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.showNextScreen()
            }
        })
    }
    
    func showNextScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
