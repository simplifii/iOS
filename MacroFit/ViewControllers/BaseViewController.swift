//
//  BaseViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 28/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    public func addBackNavbarInView(navbarView: UIView, settings_visible: Bool) {
        if let backNavbarView = Bundle.main.loadNibNamed("BackNavbarView", owner: self, options: nil)?.first as? BackNavbarView {
            navbarView.addSubview(backNavbarView)
            backNavbarView.frame.size.width = self.view.bounds.size.width
            
            backNavbarView.backButton.addTarget(self, action: #selector(self.goBackToPreviousScreen(_:)), for: UIControlEvents.touchUpInside)
            
            backNavbarView.settingsButton.addTarget(self, action: #selector(self.goToSettingsScreen(_:)), for: UIControlEvents.touchUpInside)
            
            if settings_visible == true {
                backNavbarView.settingsButton.isHidden = false
            }
        }
    }
    
    @objc func goBackToPreviousScreen(_ sender: UIButton) {
        //        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goToSettingsScreen(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasicInfoViewController") as? BasicInfoViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    public func showAlertMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        action.setValue(Constants.schemeColor, forKey: "titleTextColor")
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }

}
