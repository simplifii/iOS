//
//  FitnessTableViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 23/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class FitnessTableViewController: UITableViewController {

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
        return 4
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var action = ""
        switch indexPath.row {
        case 0:
            action = "One"
        case 1:
            action = "Two"
        case 2:
            action = "Three"
        case 3:
            action = "Four"
        default:
            break
        }
        
        if (action == "One") {
            let vc = UIStoryboard(name: "Challenges", bundle: nil).instantiateViewController(withIdentifier: "ChallengeViewController") as? ChallengeViewController
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        } else  if (action == "Two") {
            let vc = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "CourseViewController") as? CourseViewController
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        } else{
            print("action",action)
            let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "ThankYouViewController") as? ThankYouViewController
            vc?.action = action
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }

}
