//
//  SleepyBoye.swift
//  Commotion
//
//  Created by Kevin Queenan on 12/5/17.
//  Copyright © 2017 Eric Larson. All rights reserved.
//

import UIKit
import Foundation

class SleepyBoye: NSObject {
    
    // raw data
    var startDate: Date!
    var endDate: Date!
    var events = [Int]()
    var deepSleep: Int!
    var lightSleep: Int!
    var awake: Int!
    
    // calculated metrics
    var deepSleepPercentage: Double!
    var lightSleepPercentage: Double!
    var awakePercentage: Double!
    var sleepScore: Int!
    
    // constructor
    init(night: NightyNight) {
        super.init()
        self.startDate = night.eventStart
        self.endDate = night.eventEnd
        self.events = night.motionEvents
        self.deepSleep = 0
        self.lightSleep = 0
        self.awake = 0
        self.deepSleepPercentage = 0.0
        self.lightSleepPercentage = 0.0
        self.awakePercentage = 0.0
        self.sleepScore = 0
        analyzeEvents()
        scoring()
    }
    
    // categorical sleep analysis
    func analyzeEvents() {
        for event in self.events {
            if event < 5 {
                deepSleep = deepSleep + 1
            }
            else if event < 7 {
                lightSleep = lightSleep + 1
            }
            else {
                awake = awake + 1
            }
        }
    }
    
    func scoring() {
        
    }
    
    // return values
    func getSleep() -> (deepSleep: Int, lightSleep: Int, awake: Int, start: Date, end: Date)
    {
        return (self.deepSleep, self.lightSleep, self.awake, self.startDate, self.endDate)
    }
    
    
    

    
}
