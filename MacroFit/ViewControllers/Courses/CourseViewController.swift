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
    var daysJSON: [[JSON]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysJSON = [
            [  //Day 1
                ["title" : "Squats",
                 "time" : "01:00",
                 "done" : true ],
                ["title" : "Dumbbell Row",
                 "reps" : 10,
                 "done" : false ],
                ["title" : "Planks x30 seconds",
                 "reps" : 3,
                 "time" : "01:30"]
            ],
            [], //Day 2
            []  //Day 3
        ]
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 2 }
        return daysJSON?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: indexPath.row == 0 ? "HeaderCell" : "DescriptionCell", for: indexPath)
            (cell as? CourseDescriptionCell)?.titleLabel.text = courseJSON?["title"].string
            (cell as? CourseDescriptionCell)?.descriptionLabel.text = courseJSON?["description"].string
            
            (cell as? CourseHeaderCell)?.backgroundImageView.image = nil
            if let urlString = courseJSON?["image"].rawString(), let url = URL(string: urlString) {
                (cell as? CourseHeaderCell)?.backgroundImageView.af_setImage(withURL: url)
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "DaysCell", for: indexPath)
            (cell as? CourseDayCell)?.exercises = daysJSON?[indexPath.row] ?? []
            (cell as? CourseDayCell)?.textLabel?.text = "Day \(indexPath.row + 1)"
            (cell as? CourseDayCell)?.parent = self
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 && indexPath.section == 0 ? 180 : UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section != 0, let dayJSON = daysJSON?[indexPath.row] else  { return }
        
        let vc = UIStoryboard(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: "Day")
        
        (vc as? CourseDayViewController)?.dayJSON = dayJSON
        navigationController?.pushViewController(vc, animated: true)
    }
}

class CourseHeaderCell: UITableViewCell {
    @IBOutlet weak var backgroundImageView: UIImageView!
}
