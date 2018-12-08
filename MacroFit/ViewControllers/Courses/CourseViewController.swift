//
//  CourseViewController.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/21/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import AVKit
import SwiftyJSON

class CourseViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var courseJSON: JSON? {
        didSet {
            getDaysJSON()
        }
    }
    var lessonsJSON: [JSON]?
    var exercisesJSON: [String : JSON] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CourseHeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableView.register(UINib(nibName: "CourseDescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getDaysJSON() {
        if let courseId = courseJSON?["id"].rawString() {
            APIService.getLessons(for: courseId, completion: { [weak self] success, msg, data in
                let lessons = data["course"]["lessons"].array
                self?.lessonsJSON = lessons
                
                for lessonJSON in (lessons ?? []) {
                    if let lessonId = lessonJSON["id"].rawString() {
                        APIService.getExercises(for: lessonId, completion:  { [weak self] success, msg, data2 in
                            let exercises = data2["lesson"]["exercises"]
                            self?.exercisesJSON[lessonId] = exercises
                            self?.tableView.reloadData()
                        })
                    }
                }
                self?.tableView.reloadData()
            })
        }
    }
}

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 2 }
        return lessonsJSON?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: indexPath.row == 0 ? "HeaderCell" : "DescriptionCell", for: indexPath)
            (cell as? CourseDescriptionCell)?.titleLabel.text = courseJSON?["title"].string
            (cell as? CourseDescriptionCell)?.descriptionLabel.text = courseJSON?["description"].string
            
            (cell as? CourseHeaderCell)?.backgroundImageView.image = nil
            if let urlString = courseJSON?["photo"].string, let url = URL(string: urlString) {
                (cell as? CourseHeaderCell)?.backgroundImageView.af_setImage(withURL: url)
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "DaysCell", for: indexPath)
            if let lesson = lessonsJSON?[indexPath.row], let key = lesson["id"].rawString(), let exercises = exercisesJSON[key] {
                (cell as? CourseDayCell)?.exercises = exercises.array ?? []
            }
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
        if indexPath.section == 0 {
            guard indexPath.row == 0 else { return }
            if let videoString = courseJSON?["video"].string, let url = URL(string: videoString) {
                let player = AVPlayer(url: url)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                present(playerViewController, animated: true) {
                    player.play()
                }
            }
        }
            
        guard let lessonJSON = lessonsJSON?[indexPath.row] else  { return }
        
        let vc = UIStoryboard(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: "Day")
        
        
        if let dayVC = vc as? CourseDayViewController {
            dayVC.headerText =  "Day \(indexPath.row + 1)"
            if let key = lessonJSON["id"].rawString(), let exercises = exercisesJSON[key]?.array {
                dayVC.dayJSON = exercises
            }
            dayVC.courseJSON = courseJSON
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

class CourseHeaderCell: UITableViewCell {
    @IBOutlet weak var backgroundImageView: UIImageView!
}
