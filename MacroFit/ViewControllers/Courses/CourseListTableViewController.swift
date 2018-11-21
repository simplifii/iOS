//
//  CourseListViewController.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/20/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseListViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    fileprivate let reuseIdentifier = "cellReuseIdentifier"
    
    var coursesJSON: [JSON]?
    var courseType: String?
    
    override func viewDidLoad() {
        title = courseType == nil ? nil : courseType! + " courses"
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "IndividualCourseTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
}

extension CourseListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesJSON?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let courseCell = cell as? IndividualCourseTableViewCell, let course = coursesJSON?[indexPath.row] {
            courseCell.courseNameLabel.text = course["title"].rawString()
            courseCell.subtitleLabel.text = "by Fitness Duder"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let course = coursesJSON?[indexPath.row], let vc = UIStoryboard(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: "Course") as? CourseViewController else { return }
        
        vc.courseJSON = course
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
