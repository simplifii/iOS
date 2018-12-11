//
//  SignUpViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 17/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: SignUpBaseViewController {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var signUpWithFBButton: UIButton!
    
    var name = String()
    var email = String()
    var mobile = String()
    var password = String()
    
    var credits:Int = 0
    
    var signUpFormTableViewControoler: SignUpFormTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
        
        addFacebookIconInButton(button: signUpWithFBButton)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validateFields() -> Bool {
        if (name.isEmpty) {
            showAlertMessage(title: "Name is required", message: nil)
            return false
        }
        if (email.isEmpty) {
            showAlertMessage(title: "Email is required", message: nil)
            return false
        }
        if (mobile.isEmpty) {
            showAlertMessage(title: "Phone is required", message: nil)
            return false
        }
        if (password.isEmpty) {
            showAlertMessage(title: "Password is required", message: nil)
            return false
        }
        
        return true
    }
    
    @IBAction func signUpUser(_ sender: UIButton) {
        setFieldsData()
        if validateFields() == false {
            return
        }

        createUser(sender: sender)
    }
    
    func setFieldsData() {
        name = signUpFormTableViewControoler.name
        email = signUpFormTableViewControoler.email
        mobile = signUpFormTableViewControoler.mobile
        password = signUpFormTableViewControoler.password
    }
    
    func createUser(sender: UIButton) {
        sender.isEnabled = false
        Alamofire.request(APIRouter.createUser(name: name, email: email, password: password, phone: mobile, zip_code: "", promocode: ""))
            .validate(statusCode: 200..<501)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        if let status_code = response.response?.statusCode {
                            if status_code == 200 {
                                self.credits = json["response"]["data"][0]["credits"].intValue
                                
                                APIService.loginUser(username: self.email, password: self.password, completion: {success,msg in
                                    
                                    sender.isEnabled = true
                                    
                                    if success == false {
                                        self.showAlertMessage(title: msg, message: nil)
                                    } else {
                                        self.signUpProcessCompleted()
                                    }
                                })
                            } else {
                                sender.isEnabled = true
                                
                                if let msg = json["msg"].string {
                                    self.showAlertMessage(title: msg, message: nil)
                                }
                            }
                        } else {
                            sender.isEnabled = true
                        }
                    case .failure(let error):
                        sender.isEnabled = true
                        
                        print(error)
                }
        }
    }
    
    func signUpProcessCompleted() {
        if credits > 0 {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReceivedCreditViewController") as? ReceivedCreditViewController
            vc?.credits = credits
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        } else {
            self.signUpCompleted()
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SignUpFormTableViewController{
            let vc = segue.destination as! SignUpFormTableViewController
            signUpFormTableViewControoler = vc
        } else if segue.destination is LoginViewController {
            let vc = segue.destination as! LoginViewController
            vc.showNavbar = true
        }
    }
    
    
    @IBAction func loginUsingFacebook(_ sender: UIButton) {
        loginWithFacebook()
    }
    
}
