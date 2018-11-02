//
//  Setting.swift
//  MacroFit
//
//  Created by devendra kumar on 02/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class Setting: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var SettingName = ["Profile","Address","Food preferances","Macros"]
    var SettingImage = ["user","location","turkey","apple"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        // Do any additional setup after loading the view.
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
        if indexPath.row == 0
        {
            let storyBoard:UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        }
    }
    
}
