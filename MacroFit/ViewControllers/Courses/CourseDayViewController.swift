//
//  CourseDayViewController.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/23/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON
import EzPopup

extension Notification.Name {
    public static let CourseDay_WeightPressed = Notification.Name(rawValue: "CourseDayViewController.WeightPressed")
    public static let CourseDay_RepsPressed = Notification.Name(rawValue: "CourseDayViewController.RepsPressed")
}

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
        NotificationCenter.default.addObserver(self, selector: #selector(nextExercise), name: .exerciseCompleted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(restOver), name: .restOverPressed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(modifierPressed), name: .CourseDay_WeightPressed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(modifierPressed), name: .CourseDay_RepsPressed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(attributeModified), name: .modifierApplyPressed, object: nil)
        
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
        vc.timeToCount = 60.9
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func nextExercise() {
        dayJSON?[activeExerciseIndex]["done"] = true
        activeExerciseIndex += 1
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @objc func modifierPressed(_ note: Notification) {
        switch note.name {
        case .CourseDay_WeightPressed:
            let content = UIStoryboard(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: "NumberModifier") as! NumberModifierViewController
            let popup = PopupViewController(contentController: content, position: .center(nil), popupWidth: 300, popupHeight: 200)
            var options: [String] = []
            for i in 1...50 {
                options.append("\(i)")
            }
            for i in 11...40 {
                options.append("\(i * 5)")
            }
            content.options = options
            content.displayTitle = "Weight (lb)"
            content.modifierKey = "weight"
            present(popup, animated: true, completion: nil)
        case .CourseDay_RepsPressed:
            let content = UIStoryboard(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: "NumberModifier") as! NumberModifierViewController
            let popup = PopupViewController(contentController: content, position: .center(nil), popupWidth: 300, popupHeight: 200)
            var options: [String] = []
            for i in 1...100 {
                options.append("\(i)")
            }
            content.options = options
            content.displayTitle = "Reps"
            content.modifierKey = "reps"
            present(popup, animated: true, completion: nil)
        default:
            break
        }
    }
    
    @objc func attributeModified(_ note: Notification) {
        let info = note.userInfo
        
        //Figure out the active exercise:
        let ex = dayJSON?[activeExerciseIndex]
        
        //Then figure out if info is on weight or reps:
        let isWeight = (info?["modifierKey"] as? String) == "weight" //untested
        
        //Then modify ex accordingly
        
        //The problem with this is that this doesn't propagate through the whole model
        
        //SOOOO the course of action would be to keep the state in ExerciseManager.  And then sync that in bits and pieces as needed.
    }
    
    @objc func restOver() {
        navigationController?.popToViewController(self, animated: true)
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
            if let urlString = courseJSON?["photo"].rawString(), let url = URL(string: urlString) {
                (cell as? CourseHeaderCell)?.backgroundImageView.af_setImage(withURL: url)
            }
            
            cell.selectionStyle = .none

            return cell
        } else if indexPath.section == 1 {
            guard let exercise = dayJSON?[indexPath.row] else { return UITableViewCell() }
            
            var reuseIdentifier = "Exercise"
            
            let repsInt = exercise["recommended_reps"].int
            let weightGrams = exercise["recommended_weight_in_gms"].double
            let time = exercise["recommended_duration_in_secs"].double
            
            if indexPath.row == activeExerciseIndex {
                //3 cases:
                
                //1: reps and weight are nil: Time only
                
                //2: time is nil: Weight, reps
                
                //3: weight is nil: Time, reps
                
                if repsInt == nil && weightGrams == nil {
                    reuseIdentifier = "ExerciseExpandedTime"
                } else if time == nil {
                    reuseIdentifier = "ExerciseExpandedReps"
                } else if weightGrams == nil {
                    reuseIdentifier = "ExerciseExpandedTimeReps"
                }
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ExerciseCell
            cell.exerciseNameLabel.text = exercise["title"].rawString()
            cell.exerciseID = exercise["id"].intValue
            
            if let t = time {
                cell.rightDetailLabel.text = MFTimeFormatter.formatter.clockStyleDurationString(fromSeconds: t)
                if let reps = repsInt {
                    cell.leftDetailLabel.text = "\(reps) rep\(reps > 1 ? "s" : "")"
                }
            } else if let reps = repsInt {
                //Otherwise it's just reps, if so. - clear out the reps label and put reps in time.
                cell.rightDetailLabel.text = "\(reps) rep\(reps > 1 ? "s" : "")"
            }
            
            (cell as? RepsExerciseCell)?.numReps = repsInt
            (cell as? RepsExerciseCell)?.grams = weightGrams
            (cell as? TimeRepsExerciseCell)?.repsCount = repsInt
            (cell as? TimeRepsExerciseCell)?.minTime = time ?? 0
            
            cell.doneImageView.image = UIImage(named: ExerciseManager.manager.exerciseComplete(exerciseID: exercise["id"].intValue) ? "done" : "undone")
            
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
    var exerciseID: Int = 0
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
    
    @IBAction func completePressed(_ sender: Any) {
        ExerciseManager.manager.recordExercise(exerciseID: exerciseID)
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
}

class RepsExerciseCell: ExerciseCell {
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var weightButton: UIButton!
    @IBOutlet weak var repsButton: UIButton!
    
    var grams: Double?
    var numReps: Int?
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        updateText()
    }
    
    func updateText() {
        let numberAttributes: [NSAttributedStringKey: Any] = [.font : UIFont(name: weightButton.titleLabel!.font.fontName, size: 24)!,
                                                              .foregroundColor : UIColor.black
        ]
        let unitsAttributes: [NSAttributedStringKey: Any] = [.font : UIFont(name: weightButton.titleLabel!.font.fontName, size: 17)!,
                                                             .foregroundColor : UIColor.darkGray
        ]
        
        let weightString = NSMutableAttributedString()
        
        if let g = MFNumberFormatter.formatter.stringFromWeight(grams: grams) {
            weightString.append(NSAttributedString(string: "\(g)", attributes: numberAttributes))
            weightString.append(NSAttributedString(string: "\(MFNumberFormatter.formatter.weightUnitString)   ", attributes: unitsAttributes))
        }
        
        weightButton.setAttributedTitle(weightString, for: .normal)
        weightButton.isHidden = weightString.string.count == 0
        
        let repString = NSMutableAttributedString()
        
        if let reps = numReps {
            repString.append(NSAttributedString(string: "\(reps)", attributes: numberAttributes))
            repString.append(NSAttributedString(string: " reps", attributes: unitsAttributes))
        }
        repsButton.setAttributedTitle(repString, for: .normal)
        repsButton.isHidden = repString.string.count == 0
    }
    
    @IBAction func weightPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .CourseDay_WeightPressed, object: nil)
    }
    
    @IBAction func repsPressed(_ sender: Any) {
        NotificationCenter.default.post(name: .CourseDay_RepsPressed, object: nil)
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
