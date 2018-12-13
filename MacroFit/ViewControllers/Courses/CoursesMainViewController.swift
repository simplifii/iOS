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
    @IBOutlet weak var containerView: UIView!
    private weak var subNavController: UINavigationController?
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet var containerExpanded: NSLayoutConstraint!
    @IBOutlet var containerCollapsed: NSLayoutConstraint!
    
    @IBAction func backPressed(_ sender: Any) {
        if let sub = subNavController, sub.childViewControllers.count > 1 {
            sub.popViewController(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigationRoot" {
            subNavController = segue.destination as? UINavigationController
            subNavController?.delegate = self
        }
    }
}

extension CoursesContainer: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if navigationController == subNavController {
            titleLabel.text = viewController.title
            subtitleLabel.text = (viewController as? DescriptionContainer)?.descriptiveText
            let hide = (titleLabel.text == nil || titleLabel.text!.count == 0) && (subtitleLabel.text == nil || subtitleLabel.text!.count == 0)
            if hide {
                containerCollapsed.isActive = false
                containerExpanded.isActive = true
            } else {
                containerExpanded.isActive = false
                containerCollapsed.isActive = true
            }
        }
    }
}

protocol DescriptionContainer {
    var descriptiveText: String { get }
}

class CoursesMainViewController: BaseViewController {
    fileprivate var coursesJSON:JSON = []
    fileprivate let reuseIdentifier = "courseCell"
    fileprivate var courseCategories:[String:[JSON]] = [:]
    fileprivate var categoryImages:[String:String] = [:]
    @IBOutlet var tableView: UITableView!
    
    fileprivate let imageNames = ["sports" : "splash-sports",
                                  "strength" : "splash-strength",
                                  "weights" : "splash-weights",
                                  "yoga" : "splash-yoga",
                                  "beginner" : "splash-sports",
                                  "popular" : "splash-yoga",
                                  "strengthening" : "splash-strength"]
    fileprivate let iconNames = ["crossfit" : "crossfit",
                                 "sports" : "sports",
                                 "strength" : "strength",
                                 "yoga" : "yoga",
                                 "beginner" : "sports",
                                 "popular" : "yoga",
                                 "strengthening" : "strength"]
    
    override func viewDidLoad() {
        title = "Fitness courses"
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CourseCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        APIService.getCourses(completion: { [weak self] success, msg, data in
            if success {
                self?.coursesJSON = data["courses"]
                var tempCourseCategories:[String:[JSON]] = [:]
                var tempCategoryImages:[String:String] = [:]
                for course in data["courses"] {
                    if let courseTags = course.1["tags"].rawString(), courseTags != "null" {
                        for t in courseTags.split(separator: ",") {
                            let key = String(t)
                            if tempCourseCategories[key] == nil {
                                tempCourseCategories[key] = [JSON]()
                                tempCategoryImages[key] = course.1["photo"].rawString()
                            }
                            
                            tempCourseCategories[key]?.append(course.1)
                        }
                    } else {
                        let key = "Other"
                        if tempCourseCategories[key] == nil {
                            tempCourseCategories[key] = [JSON]()
                            tempCategoryImages[key] = course.1["photo"].rawString()
                        }
                        
                        tempCourseCategories[key]?.append(course.1)
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
}

extension CoursesMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseCategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let categoryTitle = courseCategories.keys.sorted()[indexPath.row]
        let key = categoryTitle.lowercased()
        let iconName = iconNames[key] ?? iconNames[iconNames.keys.sorted()[indexPath.row % iconNames.count]]
        let backgroundName = imageNames[key] ?? imageNames[imageNames.keys.sorted()[indexPath.row % imageNames.count]]
        
        if let categoryCell = cell as? CourseCategoryTableViewCell {
            categoryCell.titleLabel.text = categoryTitle
            if let img = backgroundName {
                categoryCell.backgroundImageView.image = UIImage(named: img)
            }
            if let icon = iconName {
                categoryCell.iconImage.image = UIImage(named: icon)
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryTitle = courseCategories.keys.sorted()[indexPath.row]
        let coursesInCategory = courseCategories[categoryTitle]
        
        if let courseListVC = UIStoryboard(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: "CourseList") as? CourseListViewController {
            courseListVC.coursesJSON = coursesInCategory
            courseListVC.courseType = categoryTitle
            navigationController?.pushViewController(courseListVC, animated: true)
        }
    }
}

extension CoursesMainViewController: DescriptionContainer {
    var descriptiveText: String {
        return "Fitness courses designed by LA's best coaches"
    }
}
