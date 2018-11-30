//
//  ExerciseManager.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/28/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

extension Notification.Name {
    public static let exerciseTimeUpdated = Notification.Name(rawValue: "timeUpdated")
    public static let exerciseCompleted = Notification.Name(rawValue: "exerciseCompleted")
}

class ExerciseManager: NSObject {
    static let manager = ExerciseManager()
    private var _stopwatch: Stopwatch
    var stopwatch: Stopwatch { return _stopwatch }
    private var notificationTimer: Timer!
    
    var currentExercise: String?
    var currentRound: Int = 0
    
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
    
    func recordCurrentExercise() {
        stopwatch.reset()
        //TODO make API call
        if let e = currentExercise {
            NotificationCenter.default.post(name: .exerciseCompleted, object: nil, userInfo: ["exercise" : e])
        }
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
