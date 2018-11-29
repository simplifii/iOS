//
//  CourseDayViewController.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/23/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseDayViewController: BaseViewController {
    
    var dayJSON: [JSON]?
    var courseJSON: JSON?
    var headerText: String?
    fileprivate var roundNumber = 1

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CourseHeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableView.register(UINib(nibName: "CourseDescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CourseDayViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : (dayJSON?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: indexPath.row == 0 ? "HeaderCell" : "DescriptionCell", for: indexPath)
            //Set up title, description, and header
            (cell as? CourseDescriptionCell)?.titleLabel.text = headerText
            (cell as? CourseDescriptionCell)?.descriptionLabel.text = "Round \(roundNumber): \(roundNumber)/\(dayJSON?.count ?? 0)"

            (cell as? CourseHeaderCell)?.backgroundImageView.image = nil
            if let urlString = courseJSON?["image"].rawString(), let url = URL(string: urlString) {
                (cell as? CourseHeaderCell)?.backgroundImageView.af_setImage(withURL: url)
            }
            
            cell.selectionStyle = .none

            return cell
        } else {
            guard let day = dayJSON?[indexPath.row] else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCell(withIdentifier: roundNumber == indexPath.row + 1 ? "ExerciseExpandedTime" : "Exercise", for: indexPath) as! ExerciseCell
            cell.exerciseNameLabel.text = day["title"].rawString()
            if let time = day["time"].string {
                cell.rightDetailLabel.text = time
                if let reps = day["reps"].int {
                    cell.leftDetailLabel.text = "\(reps) reps"
                }
            } else if let reps = day["reps"].int {
                //Otherwise it's just reps, if so. - clear out the reps label and put reps in time.
                cell.rightDetailLabel.text = "\(reps) reps"
            }
            cell.doneImageView.image = UIImage(named: day["done"].boolValue ? "done" : "undone")
            
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 && indexPath.section == 0 ? 180 : UITableViewAutomaticDimension
    }
}

class ExerciseCell : UITableViewCell {
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var rightDetailLabel: UILabel!
    @IBOutlet weak var leftDetailLabel: UILabel!
    @IBOutlet weak var doneImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leftDetailLabel.text = nil
        rightDetailLabel.text = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leftDetailLabel.text = nil
        rightDetailLabel.text = nil
    }
}

class TimeExerciseCell: ExerciseCell {
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    var minTime: TimeInterval = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: .exerciseTimeUpdated, object: nil)
        updateLabels(0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        minTime = 0
        updateLabels(0)
    }
    
    @objc func notificationReceived(_ note: Notification) {
        if let time = note.userInfo?["time"] as? TimeInterval {
            updateLabels(time)
        }
    }
    
    func updateLabels(_ time: TimeInterval) {
        timeLabel.text = MFTimeFormatter.formatter.clockStyleDurationString(fromSeconds: time)
        completeButton.isEnabled = minTime < time
        playPauseButton.setTitle(ExerciseManager.manager.stopwatch.running ? "Pause" : "Start", for: .normal)
    }
    
    @IBAction func playPausePressed(_ sender: UIButton) {
        let wasPaused = sender.title(for: .normal) == "Start"
        sender.setTitle( wasPaused ? "Pause" : "Start", for: .normal)
        wasPaused ? ExerciseManager.manager.stopwatch.start() : ExerciseManager.manager.stopwatch.pause()
    }
    
    @IBAction func completePressed(_ sender: Any) {
        ExerciseManager.manager.recordCurrentExercise()
    }
}

class RepsExerciseCell: ExerciseCell {
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var weightsLabel: UILabel!
    
    var numPounds: Double?
    var numReps: Int?
    
    func updateText() {
        let numberAttributes: [NSAttributedStringKey: Any] = [.font : UIFont(name: weightsLabel.font.fontName, size: 24)!,
                                                              .foregroundColor : UIColor.black
        ]
        let unitsAttributes: [NSAttributedStringKey: Any] = [.font : UIFont(name: weightsLabel.font.fontName, size: 17)!,
                                                             .foregroundColor : UIColor.darkGray
        ]
        
        let attrString = NSMutableAttributedString()
        
        if let lbs = numPounds {
            attrString.append(NSAttributedString(string: "\(lbs)", attributes: numberAttributes))
            attrString.append(NSAttributedString(string: "lb   ", attributes: unitsAttributes))
        }
        
        if let reps = numReps {
            attrString.append(NSAttributedString(string: "\(reps)", attributes: numberAttributes))
            attrString.append(NSAttributedString(string: " reps", attributes: unitsAttributes))
        }
        
        weightsLabel.attributedText = attrString
    }
}
