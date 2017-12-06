//
//  NightyNight.swift
//  Commotion
//
//  Created by Logan Dorsey on 12/5/17.
//  Copyright © 2017 Eric Larson. All rights reserved.
//

import Foundation

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
    }
    
    required init?(coder aDecoder: NSCoder) {
        <#code#>
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
    
}
