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

class SignUpViewController: OnboardUserViewController {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    
    var name = String()
    var email = String()
    var mobile = String()
    var password = String()
    var zipcode = String()
    
    var signUpFormTableViewControoler: SignUpFormTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackNavbarInView(navbarView: navbarView)
        self.addProgressBarInView(progressBarView: progressBarView, percent: 20, description: nil)
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
        if (zipcode.isEmpty) {
            showAlertMessage(title: "Zip code is required", message: nil)
            return false
        }
        
        return true
    }
    
    @IBAction func signUpUser(_ sender: Any) {
        setFieldsData()
        if validateFields() == false {
            return
        }
        createUser()
    }
    
    func setFieldsData() {
        name = signUpFormTableViewControoler.nameTextField.text!
        email = signUpFormTableViewControoler.emailTextField.text!
        mobile = signUpFormTableViewControoler.phoneTextField.text!
        password = signUpFormTableViewControoler.passwordTextField.text!
        zipcode = signUpFormTableViewControoler.zipCodeTextField.text!
    }
    
    func createUser() {
        Alamofire.request(APIRouter.createUser(name: name, email: email, password: password, phone: mobile, zip_code: zipcode))
            .validate(statusCode: 200..<501)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                print(response.result)
                switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        if let status_code = response.response?.statusCode {
                            if status_code == 200 {
                                self.signUpCompleted()
                            } else {
                                if let msg = json["msg"].string {
                                    self.showAlertMessage(title: msg, message: nil)
                                }
                            }
                        }
                        print(json)
                        print("Validation ")
                    case .failure(let error):
                        print(error)
                }
        }
    }
    
    func signUpCompleted() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasicInfoViewController") as? BasicInfoViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUpFormTableViewController"{
            let vc = segue.destination as! SignUpFormTableViewController
            signUpFormTableViewControoler = vc
        }
    }
}
