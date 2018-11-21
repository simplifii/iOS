//
//  CourseViewController.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/21/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var courseJSON: JSON?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
}

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var dayCount = 0
        
        
        //1 for header, 1 for description, then 1 for each day
        return 2 + dayCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: indexPath)
        }
        
        return cell
    }
    
    
}
