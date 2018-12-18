//
//  SideMenuFormTableViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 16/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuFormTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            let height = Int(UIScreen.main.bounds.height) - (50 * (tableView.numberOfRows(inSection: 0))) - 87 - 50
            return CGFloat(height)
        }
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //Devendra Rai Code
            
            showSettingsScreen()
//            showBasicProfileSettingsScreen()
        }
        if indexPath.row == 2 {
            gotoInviteFriendsScreen()
        }
        if indexPath.row == 6 {
            logout()
        }
    }
    
    func showSettingsScreen() {
        print("press")
        let basicInfoVC = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "Setting") as? Setting
        self.navigationController?.pushViewController(basicInfoVC!, animated: true)
        
    }
    func showBasicProfileSettingsScreen() {
        let basicInfoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasicInfoViewController") as? BasicInfoViewController
        
        self.navigationController?.pushViewController(basicInfoVC!, animated: true)

    }
    
    func gotoInviteFriendsScreen() {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "ReferFriendViewController") as? ReferFriendViewController
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    func logout() {
        APIService.logoutUser(completion: {success,msg in
            if success == true {
                self.dismiss(animated: true, completion: nil)
                self.gotoLoginScreen()
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    func showAlertMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        action.setValue(ColorConstants.schemeColor, forKey: "titleTextColor")
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    func gotoLoginScreen() {
        self.removeUserToken()
        
        self.navigationController?.viewControllers.removeAll()
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationViewController") as? UINavigationController
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        vc?.initRootViewController(vc: loginVC!)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    func removeUserToken() {
        UserDefaults.standard.removeObject(forKey: UserConstants.userToken)
        UserDefaults.standard.removeObject(forKey: UserConstants.userCardUniqueCode)
    }

}
