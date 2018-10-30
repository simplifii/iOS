//
//  BaseViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 28/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    

    public func addBackNavbarInView(navbarView: UIView, settings_visible: Bool) {
        if let backNavbarView = Bundle.main.loadNibNamed("BackNavbarView", owner: self, options: nil)?.first as? BackNavbarView {
            backNavbarView.frame = navbarView.bounds
            
            navbarView.addSubview(backNavbarView)
            
            backNavbarView.backButton.addTarget(self, action: #selector(self.goBackToPreviousScreen(_:)), for: UIControlEvents.touchUpInside)

            backNavbarView.settingsButton.addTarget(self, action: #selector(self.goToSettingsScreen(_:)), for: UIControlEvents.touchUpInside)

            if settings_visible == true {
                backNavbarView.settingsButton.isHidden = false
            }
        }
    }
    
    public func addMenuNavbarInView(navbarView: UIView) {
        if let menuNavbarView = Bundle.main.loadNibNamed("MenuNavbarView", owner: self, options: nil)?.first as? MenuNavbarView {
            menuNavbarView.frame = navbarView.bounds
            
            navbarView.addSubview(menuNavbarView)
            
            menuNavbarView.menuButton.addTarget(self, action: #selector(self.showSideMenu(_:)), for: UIControlEvents.touchUpInside)
        }
    }
    
    @objc func showSideMenu(_ sender: UIButton) {
        SideMenuManager.default.menuAnimationBackgroundColor = .white
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuLeftNavigationController?.navigationBar.isHidden = true
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    
    @objc func goBackToPreviousScreen(_ sender: UIButton) {
        //        self.dismiss(animated: true, completion: nil)
        self.showPreviousScreen()
    }
    
    @objc func goToSettingsScreen(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationViewController") as? UINavigationController
        
        let basicInfoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasicInfoViewController") as? BasicInfoViewController
        
        vc?.initRootViewController(vc: basicInfoVC!)
        
        self.navigationController?.viewControllers.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    
    public func showAlertMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        if title == "Token invalid" || title == "Token expired" {
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: {(alert: UIAlertAction!) in
                self.gotoLoginScreen()
            })
            action.setValue(Constants.schemeColor, forKey: "titleTextColor")

            alert.addAction(action)
        } else {
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            action.setValue(Constants.schemeColor, forKey: "titleTextColor")

            alert.addAction(action)
        }
        
        
        self.present(alert, animated: true)
    }

    func showPreviousScreen() {
        self.navigationController?.popViewController(animated: true)
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
