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
    fileprivate var activeExerciseIndex = 0

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CourseHeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        tableView.register(UINib(nibName: "CourseDescriptionCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        NotificationCenter.default.addObserver(self, selector: #selector(nextPressed), name: .courseNextPressed, object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func endWorkoutPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: "WorkoutComplete") as! WorkoutCompleteViewController
        vc.exercisesJSON = dayJSON
        vc.courseJSON = courseJSON
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func nextPressed() {
        let vc = UIStoryboard(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: "RestViewController") as! CourseRestViewController
        vc.timeToCount = 12
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CourseDayViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return (dayJSON?.count ?? 0)
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: indexPath.row == 0 ? "HeaderCell" : "DescriptionCell", for: indexPath)
            //Set up title, description, and header
            (cell as? CourseDescriptionCell)?.titleLabel.text = headerText
            (cell as? CourseDescriptionCell)?.descriptionLabel.text = "Round \(activeExerciseIndex + 1): \(activeExerciseIndex + 1)/\(dayJSON?.count ?? 0)"

            (cell as? CourseHeaderCell)?.backgroundImageView.image = nil
            if let urlString = courseJSON?["image"].rawString(), let url = URL(string: urlString) {
                (cell as? CourseHeaderCell)?.backgroundImageView.af_setImage(withURL: url)
            }
            
            cell.selectionStyle = .none

            return cell
        } else if indexPath.section == 1 {
            guard let day = dayJSON?[indexPath.row] else { return UITableViewCell() }
            
            var reuseIdentifier = "Exercise"
            
            let repsInt = day["recommended_reps"].int
            let weightDouble = day["recommended_weight"].double
            let time = day["time"].string
            
            if indexPath.row == activeExerciseIndex {
                //3 cases:
                
                //1: reps and weight are nil: Time only
                
                //2: time is nil: Weight, reps
                
                //3: weight is nil: Time, reps
                
                if repsInt == nil && weightDouble == nil {
                    reuseIdentifier = "ExerciseExpandedTime"
                } else if time == nil {
                    reuseIdentifier = "ExerciseExpandedReps"
                } else if weightDouble == nil {
                    reuseIdentifier = "ExerciseExpandedTimeReps"
                }
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ExerciseCell
            cell.exerciseNameLabel.text = day["title"].rawString()
            
            if let time = day["time"].string {
                cell.rightDetailLabel.text = time
                if let reps = repsInt {
                    cell.leftDetailLabel.text = "\(reps) rep\(reps > 1 ? "s" : "")"
                }
            } else if let reps = repsInt {
                //Otherwise it's just reps, if so. - clear out the reps label and put reps in time.
                cell.rightDetailLabel.text = "\(reps) rep\(reps > 1 ? "s" : "")"
            }
            
            (cell as? RepsExerciseCell)?.numReps = repsInt
            (cell as? RepsExerciseCell)?.numPounds = weightDouble
            (cell as? TimeRepsExerciseCell)?.repsCount = repsInt
            
            cell.doneImageView.image = UIImage(named: day["done"].boolValue ? "done" : "undone")
            
            cell.selectionStyle = .none
            
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "NextButton", for: indexPath)
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
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        updateText()
    }
    
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

class TimeRepsExerciseCell: TimeExerciseCell {
    @IBOutlet weak var repsLabel: UILabel!
    
    var repsCount: Int?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        repsLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        repsLabel.text = nil
    }
    
    override func updateLabels(_ time: TimeInterval) {
        super.updateLabels(time)
        
        let numberAttributes: [NSAttributedStringKey: Any] = [.font : UIFont(name: repsLabel.font.fontName, size: 24)!,
                                                              .foregroundColor : UIColor.black
        ]
        let unitsAttributes: [NSAttributedStringKey: Any] = [.font : UIFont(name: repsLabel.font.fontName, size: 17)!,
                                                             .foregroundColor : UIColor.darkGray
        ]
        
        let attrString = NSMutableAttributedString()
        
        if let reps = repsCount {
            attrString.append(NSAttributedString(string: "\(reps)", attributes: numberAttributes))
            attrString.append(NSAttributedString(string: " reps", attributes: unitsAttributes))
        }
        
        repsLabel.attributedText = attrString
    }
}

class CourseNextButtonCell: UITableViewCell {
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .courseNextPressed, object: nil)
    }
}
