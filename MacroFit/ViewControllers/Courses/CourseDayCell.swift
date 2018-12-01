//
//  CourseDayCell.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/23/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseDayCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    weak var parent: CourseViewController?
    
    ///Each exercise should have the keys "title", "reps", "time", and "done" - string, int, string, and bool respectively.
    var exercises: [JSON] = []
    
    fileprivate var expanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        textLabel?.isHidden = true
        parent?.tableView.beginUpdates()
        parent?.tableView.endUpdates()
    }
    
    fileprivate func toggleExpanded() {
        expanded = !expanded
        tableView.reloadData()
        setNeedsLayout()
        layoutIfNeeded()
        parent?.tableView.beginUpdates()
        parent?.tableView.endUpdates()
        tableView.allowsSelection = false
    }
}

extension CourseDayCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indexPath.section == 0 ? "HeaderCell" : "ExerciseCell", for: indexPath)
        
        (cell as? CourseDayHeaderCell)?.dayLabel.text = textLabel?.text
        (cell as? CourseDayHeaderCell)?.parent = self
        
        if indexPath.section == 1, let eCell = cell as? CourseExerciseCell {
            let exercise = exercises[indexPath.row]
            eCell.doneImageView.image = UIImage(named: ExerciseManager.manager.exerciseComplete(exerciseID: exercise["id"].intValue) ? "done" : "undone")
            eCell.exerciseTitleLabel.text = exercise["title"].rawString()
            eCell.timeLabel.text = nil
            eCell.repsLabel.text = nil
            
            var repsText: String? = nil
            if let reps = exercise["recommended_reps"].int {
                repsText = "\(reps) rep\(reps > 1 ? "s" : "")"
            }
            
            if let time = exercise["recommended_duration_in_secs"].int {
                eCell.timeLabel.text = MFTimeFormatter.formatter.durationString(fromSeconds: time)
                eCell.repsLabel.text = repsText
            } else {
                //Otherwise it's just reps, if so. - clear out the reps label and put reps in time.
                eCell.timeLabel.text = repsText
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : (expanded ? exercises.count : 0)
    }
}

class CourseDayHeaderCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    weak var parent: CourseDayCell?
    
    @IBAction func expandPressed(_ sender: UIButton) {
        parent?.toggleExpanded()
    }
}

class CourseExerciseCell: UITableViewCell {
    @IBOutlet weak var exerciseTitleLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var doneImageView: UIImageView!
}

class SelfSizedTableView: UITableView {
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        return contentSize
    }
}
