//
//  CourseRestViewController.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/29/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class CourseRestViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    private var timer: Timer!
    
    var timeToCount: TimeInterval = 60 {
        didSet {
            stopwatch?.startCountDown(from: timeToCount)
        }
    }
    var stopwatch: CountdownStopwatch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopwatch = CountdownStopwatch()
        stopwatch?.startCountDown(from: timeToCount)
        timer = Timer(timeInterval: 1.0, repeats: true, block: { [weak self ] _ in
            if self?.stopwatch?.running ?? false {
                DispatchQueue.main.async {
                    self?.timeLabel?.text = MFTimeFormatter.formatter.clockStyleDurationString(fromSeconds: self!.stopwatch!.timeRemaining)
                }
            }
        })
        RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
    }
    
    @IBAction func nextRoundPressed(_ sender: UIButton) {
        ExerciseManager.manager.currentRound += 1
    }
    
    @IBAction func endWorkoutPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Courses", bundle: nil).instantiateViewController(withIdentifier: "WorkoutComplete") as! WorkoutCompleteViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
