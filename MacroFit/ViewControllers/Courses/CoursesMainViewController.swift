//
//  CoursesMainViewController.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/19/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class CoursesContainer: BaseViewController {
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

class CoursesMainViewController: BaseViewController {
    
    fileprivate var coursesJSON:JSON = []
    fileprivate let reuseIdentifier = "courseCell"
    fileprivate var courseCategories:[String:[JSON]] = [:]
    fileprivate var categoryImages:[String:String] = [:]
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CourseTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        APIService.getCourses(completion: { [weak self] success, msg, data in
            if success {
                self?.coursesJSON = data
                var tempCourseCategories:[String:[JSON]] = [:]
                var tempCategoryImages:[String:String] = [:]
                for course in data {
                    if let courseTags = course.1["tags"].rawString() {
                        for t in courseTags.split(separator: ",") {
                            let key = String(t)
                            if tempCourseCategories[key] == nil {
                                tempCourseCategories[key] = [JSON]()
                                tempCategoryImages[key] = course.1["image"].rawString()
                            }
                            
                            tempCourseCategories[key]?.append(course.1)
                        }
                    }
                }
                
                self?.courseCategories = tempCourseCategories
                self?.categoryImages = tempCategoryImages
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                self?.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CoursesMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseCategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let key = courseCategories.keys.sorted()[indexPath.row]
//        let imageURL = categoryImages[key]
        
        if let courseCell = cell as? CourseTableViewCell {
            courseCell.titleLabel.text = key
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Init a model with all of the courses
    }
}
