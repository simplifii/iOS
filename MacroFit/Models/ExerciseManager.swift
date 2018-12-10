//
//  ExerciseManager.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/28/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

extension Notification.Name {
    public static let exerciseTimeUpdated = Notification.Name(rawValue: "timeUpdated")
    public static let exerciseCompleted = Notification.Name(rawValue: "exerciseCompleted")
    public static let courseNextPressed = Notification.Name(rawValue: "courseNextPressed")
    public static let restOverPressed = Notification.Name(rawValue: "restOverPressed")
    public static let courseFeedbackSent = Notification.Name(rawValue: "courseFeedbackSent")
}

class ExerciseManager: NSObject {
    static let manager = ExerciseManager()
    private var _stopwatch: Stopwatch
    var stopwatch: Stopwatch { return _stopwatch }
    private var notificationTimer: Timer!
    
    var currentExercise: String?
    var numberOfRounds: Int = 0
    var currentRoundNumber: Int = 1 //Indexes to 1
    var restBetweenRounds: Int = 60 //Defaults to 60
    
    var activeExercises = [Int:[JSON]]()
    
    var completedExercises: [String : Bool] = [:]
    
    private let defaultsKey = "macrofit.completedExercises"
    
    override init() {
        _stopwatch = Stopwatch()
        super.init()
        notificationTimer = Timer(timeInterval: 1.0, repeats: true, block: { [weak self ] _ in
            if self?.stopwatch.running ?? false {
                NotificationCenter.default.post(name: .exerciseTimeUpdated, object: nil, userInfo: ["time" : self!.stopwatch.elapsedTime])
            }
        })
        
//        if let archived = UserDefaults.standard.dictionary(forKey: defaultsKey) as? [String: Bool] {
//            completedExercises = archived
//        }
        
        RunLoop.main.add(notificationTimer, forMode: .defaultRunLoopMode)
    }
    
    func setActiveLesson(_ json: JSON) {
        numberOfRounds = json["number_of_rounds"].int ?? 3
        restBetweenRounds = json["rest_between_rounds"].int ?? 60
    }
    
    func setActiveExercises(_ json: [JSON]) {
        activeExercises = [:]
        for i in 0...numberOfRounds - 1 {
            activeExercises[i] = json
        }
    }
    
    func recordExercise(exerciseID: Int) {
        stopwatch.reset()
        completedExercises["\(exerciseID)-\(currentRoundNumber)"] = true
//        UserDefaults.standard.set(completedExercises, forKey: defaultsKey)
        NotificationCenter.default.post(name: .exerciseCompleted, object: nil, userInfo: nil)
    }
    
    func sendFeedback(for course: Int, stars: Int, feedback: String) {
        APIService.sendCourseFeedback(forCourse: course, starRating: stars, feedbackText: feedback, completion: {success,msg in
            NotificationCenter.default.post(name: .courseFeedbackSent, object: nil, userInfo: nil)
        })
    }
    
    func exerciseComplete(exerciseID: Int) -> Bool {
        return completedExercises["\(exerciseID)-\(currentRoundNumber)"] ?? false
    }
}

class Stopwatch {
    private var accumulatedTime: TimeInterval = 0
    private var lastStarted: Date?
    
    var elapsedTime: TimeInterval {
        return accumulatedTime - (lastStarted?.timeIntervalSinceNow ?? 0)
    }
    
    var running: Bool {
        return lastStarted != nil
    }
    
    func reset() {
        lastStarted = nil
        accumulatedTime = 0
    }
    
    func start() {
        lastStarted = Date()
    }
    
    func pause() {
        accumulatedTime -= (lastStarted?.timeIntervalSinceNow ?? 0)
        lastStarted = nil
    }
}

class CountdownStopwatch: Stopwatch {
    private var timeToCount: TimeInterval = 0
    
    var timeRemaining: TimeInterval {
        return timeToCount - elapsedTime
    }
    
    func startCountDown(from time: TimeInterval) {
        timeToCount = time
        start()
    }
}
