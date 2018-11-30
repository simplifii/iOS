//
//  SignUpFormTableViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 17/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class SignUpFormTableViewController: UITableViewController, UITextFieldDelegate {

    var name = String()
    var email = String()
    var mobile = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignUpFieldTableViewCell") as! SignUpFieldTableViewCell
        cell.textField.tag = indexPath.row
        cell.textField.delegate = self
        invalidatedField(textField: cell.textField)
        switch indexPath.row {
        case 0:
            cell.textField.placeholder = "Name"
        case 1:
            cell.textField.placeholder = "Your phone number"
            cell.textField.keyboardType = .phonePad
        case 2:
            cell.textField.placeholder = "Your email"
            cell.textField.keyboardType = .emailAddress
        case 3:
            cell.textField.placeholder = "Password"
            cell.textField.isSecureTextEntry = true
        default:
            break
        }
        
        return cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textValue = textField.text {
            setFieldValue(rowIndex: textField.tag, textValue: textValue)
            
            if isValidField(rowIndex: textField.tag, textValue: textValue) {
                validatedField(textField: textField)
            } else {
                invalidatedField(textField: textField)
            }
        }
    }
    
    func setFieldValue(rowIndex: Int, textValue: String) {
        switch rowIndex {
        case 0:
            name = textValue
        case 1:
            mobile = textValue
        case 2:
            email = textValue
        case 3:
            password = textValue
        default:
            break
        }
    }
    
    func isValidField(rowIndex: Int, textValue: String)->Bool {
        switch rowIndex {
        case 0:
            if textValue.count > 2 {
                return true
            }
        case 1:
            if textValue.count > 9 {
                return true
            }
        case 2:
            if textValue.count > 4 {
                if isValidEmail(testStr: textValue) {
                    return true
                }
            }
        case 3:
            if textValue.count > 5 {
                return true
            }
        default:
            break
        }
        
        return false
    }
    
    func validatedField(textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(red: 36/255, green: 176/255, blue: 105/255, alpha: 1.0).cgColor
        textField.layer.cornerRadius = 7.0
        
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "check_green.png")
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 10)
        textField.rightViewMode = .always
        textField.rightView = imageView
    }
    
    func invalidatedField(textField: UITextField) {
        textField.layer.borderColor = UIColor(red: 225/255, green: 225/255, blue: 224/255, alpha: 1.0).cgColor
        textField.rightView = nil
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
}
