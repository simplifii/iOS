//
//  Setting.swift
//  MacroFit
//
//  Created by devendra kumar on 02/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class Setting: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var SettingName = ["Profile","Address","Food preferances","Macros"]
    var SettingImage = ["user","location","turkey","apple"]
    
    var userProfile:JSON = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)

        tableView.layer.cornerRadius = 8.0
        
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getUserProfile()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingProfileTableViewCell", for: indexPath) as! SettingProfileTableViewCell
        cell.separatorInset = UIEdgeInsets.zero;
        cell.layoutMargins = UIEdgeInsets.zero;
        cell.preservesSuperviewLayoutMargins = false;
        
        cell.images.image = UIImage(named: SettingImage[indexPath.row])
        cell.names.text = SettingName[indexPath.row]
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 0 {
            let storyBoard:UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if indexPath.row == 1 {
            let storyBoard:UIStoryboard = UIStoryboard(name: "MacroFit", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
            nextVC.orderModelController = OrderModelController()
            let address = Address(
                addressLineOne: userProfile["cdata"]["address_line_1"].stringValue,
                addressLineTwo: userProfile["cdata"]["address_line_2"].stringValue,
                zipcode: userProfile["zipcode"].stringValue
            )
            nextVC.orderModelController.address = address
            
            nextVC.onlySetAddress = true
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }  else if indexPath.row == 2 {
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "DietaryPreferencesViewController") as! DietaryPreferencesViewController
            nextVC.userProfile = userProfile
            nextVC.previousPageIsSettings = true
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }  else if indexPath.row == 3 {
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "SetUpMacroMealPortionsViewController") as! SetUpMacroMealPortionsViewController
            nextVC.userProfile = userProfile
            nextVC.previousPageIsSettings = true
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func getUserProfile() {
        APIService.getUserProfile(completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.userProfile = data[0]
            }
        })
    }
    
}
