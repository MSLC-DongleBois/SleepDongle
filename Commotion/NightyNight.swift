//
//  NightyNight.swift
//  Commotion
//
//  Created by Logan Dorsey on 12/5/17.
//  Copyright © 2017 Eric Larson. All rights reserved.
//

import Foundation
import os.log

class NightyNight : NSObject, NSCoding
{
    
    struct PropertyKey {
        static let eventStart = "eventStart"
        static let eventEnd = "eventEnd"
        static let alarmTime = "alarmTime"
        static let motionEvents = "MotionEvents"
        static let lengthOfSleep = "lengthOfSleep"
        static let sleepScore = "sleepScore"
        static let deepSleepPercentage = "deepSleepPercentage"
        static let lightSleepPercentage = "lightSleepPercentage"
        static let awakePercentage = "awakePercentage"
        static let userClassification = "userClassification"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(eventStart, forKey: PropertyKey.eventStart)
        aCoder.encode(eventEnd, forKey: PropertyKey.eventEnd)
        aCoder.encode(alarmTime, forKey: PropertyKey.alarmTime)
        aCoder.encode(motionEvents, forKey: PropertyKey.motionEvents)
        aCoder.encode(lengthOfSleep, forKey: PropertyKey.lengthOfSleep)
        aCoder.encode(sleepScore, forKey: PropertyKey.sleepScore)
        aCoder.encode(deepSleepPercentage, forKey: PropertyKey.deepSleepPercentage)
        aCoder.encode(lightSleepPercentage, forKey: PropertyKey.lightSleepPercentage)
        aCoder.encode(awakePercentage, forKey: PropertyKey.awakePercentage)
        aCoder.encode(userClassification, forKey: PropertyKey.userClassification)
    }
    
    override init() {
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    init(start: Date, score: Int, classification: Int? = nil) {
        super.init()
        eventStart = start
        sleepScore = score
        userClassification = classification
    }
    
    
    
    // raw data values
    var eventStart = Date()
    var eventEnd = Date()
    var alarmTime = Date()
    var motionEvents = [Int]()
    
    // post analysis values
    var lengthOfSleep: DateInterval!
    var sleepScore: Int!
    var deepSleepPercentage: Double!
    var lightSleepPercentage: Double!
    var awakePercentage: Double!
    var userClassification: Int?
    
}
