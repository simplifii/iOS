//
//  SideMenuViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 16/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuManager.default.menuAnimationBackgroundColor = .white
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuLeftNavigationController?.navigationBar.isHidden = true

        userNameLabel.text = UserDefaults.standard.string(forKey: UserConstants.userName)
        userEmailLabel.text = UserDefaults.standard.string(forKey: UserConstants.userEmail)
    }
    
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is SideMenuFormTableViewController
//        {
//            let vc = segue.destination as? SideMenuFormTableViewController
//            vc?.masterNavigationController = masterNavigationController
//        }
//    }

}
