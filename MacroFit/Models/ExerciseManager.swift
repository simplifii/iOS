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
    ///Indexes to 1
    var currentRoundNumber: Int = 1
    var restBetweenRounds: Int = 60 //Defaults to 60
    var lessonID: Int = 0
    
    private var exerciseOrder = [Int]() //Keep exercises in order
    var activeExercises = [Int:[Int : JSON]]() //Map of round number to exercises
    
    private let completeKey = "complete"
    static let ActualTimeKey = "actualTimeInSeconds"
    static let ActualRepsKey = "actualReps"
    static let ActualWeightKey = "actualWeightGrams"
    
    override init() {
        _stopwatch = Stopwatch()
        super.init()
        notificationTimer = Timer(timeInterval: 1.0, repeats: true, block: { [weak self ] _ in
            if self?.stopwatch.running ?? false {
                NotificationCenter.default.post(name: .exerciseTimeUpdated, object: nil, userInfo: ["time" : self!.stopwatch.elapsedTime])
            }
        })
        
        RunLoop.main.add(notificationTimer, forMode: .defaultRunLoopMode)
    }
    
    func setActiveLesson(_ json: JSON) {
        numberOfRounds = json["number_of_rounds"].int ?? 3
        restBetweenRounds = json["rest_between_rounds"].int ?? 60
        lessonID = json["id"].int ?? 0
    }
    
    func setActiveExercises(_ json: [JSON]) {
        activeExercises = [:]
        exerciseOrder = []
        for i in 0...numberOfRounds - 1 {
            var tmp = [Int:JSON]()
            for ex in json {
                let key = ex["id"].int ?? 0
                if !exerciseOrder.contains(key) { exerciseOrder.append(key) }
                tmp[key] = ex
            }
            activeExercises[i] = tmp
        }
    }
    
    func activeExercise(at index: Int) -> JSON? {
        guard currentRoundNumber - 1 < activeExercises.keys.count else { return nil }
        // -1 because currentRoundNumber is human readable
        return activeExercises[currentRoundNumber - 1]![exerciseOrder[index]]
    }
    
    func orderedExercises(in round: Int) -> [JSON] {
        var tmp = [JSON]()
        if let dict = activeExercises[round] {
            for key in exerciseOrder {
                if let ex = dict[key] {
                    tmp.append(ex)
                }
            }
        }
        return tmp
    }
 
    func recordExercise(exerciseID: Int) {
        let time = stopwatch.elapsedTime
        stopwatch.reset()
        
        guard activeExercises[currentRoundNumber - 1] != nil, activeExercises[currentRoundNumber - 1]![exerciseID] != nil else { return }
        activeExercises[currentRoundNumber - 1]![exerciseID]![completeKey] = true
        if time > 0 {
            activeExercises[currentRoundNumber - 1]![exerciseID]![ExerciseManager.ActualTimeKey] = JSON(integerLiteral: Int(time))
        }
        NotificationCenter.default.post(name: .exerciseCompleted, object: nil, userInfo: nil)
    }
    
    func sendFeedback(for course: Int, stars: Int, feedback: String) {
        APIService.sendCourseFeedback(forCourse: course, starRating: stars, feedbackText: feedback, completion: {success,msg in
            NotificationCenter.default.post(name: .courseFeedbackSent, object: nil, userInfo: nil)
        })
    }
    
    func setWeight(grams: Int, for exerciseID: Int) {
        guard activeExercises[currentRoundNumber - 1] != nil, activeExercises[currentRoundNumber - 1]![exerciseID] != nil else { return }
        activeExercises[currentRoundNumber - 1]![exerciseID]![ExerciseManager.ActualWeightKey] = JSON(integerLiteral: grams)
    }
    
    func setReps(_ reps: Int, for exerciseID: Int) {
        guard activeExercises[currentRoundNumber - 1] != nil, activeExercises[currentRoundNumber - 1]![exerciseID] != nil else { return }
        activeExercises[currentRoundNumber - 1]![exerciseID]![ExerciseManager.ActualRepsKey] = JSON(integerLiteral: reps)
    }
    
    func exerciseComplete(exerciseID: Int) -> Bool {
        guard activeExercises[currentRoundNumber - 1] != nil, activeExercises[currentRoundNumber - 1]![exerciseID] != nil else { return false }
        return activeExercises[currentRoundNumber - 1]![exerciseID]![completeKey].boolValue
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
