//
//  weaekSheduleViewController.swift
//  MacroFit
//
//  Created by Sachin Arora on 15/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//
import UIKit

class weaekSheduleViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var data = [Detamodeltocolleps(headerName: "Day 1", isExpandable: false),Detamodeltocolleps(headerName: "Day 2", isExpandable: false),Detamodeltocolleps(headerName: "Day 3", isExpandable: false),Detamodeltocolleps(headerName: "Day 4", isExpandable: false)]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
extension weaekSheduleViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data[section].isExpandable
        {
            return 1
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 70
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "WeakSheduleTableViewCell", for: indexPath) as! WeakSheduleTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if data[indexPath.section].isExpandable
        {
            return 210
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        headerView.delegate = self
        headerView.secIndex = section
        headerView.btn.setTitle(data[section].headerName, for: .normal)
    
        return headerView
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//
//        let label = UILabel()
//        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
//        label.text = "Notification Times"
//        label.font = UIFont().futuraPTMediumFont(16) // my custom font
//        label.textColor = UIColor.black // my custom colour
//
//        headerView.addSubview(label)
        
//        return headerView
    }
}

extension weaekSheduleViewController: HeaderDelegate{
    func calHeader(idx: Int) {
        data[idx].isExpandable = !data[idx].isExpandable
        tableView.reloadSections([idx], with: .automatic)
    }
    
    
}
