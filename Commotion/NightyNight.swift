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
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Nights")
    
    struct PropertyKey {
        static let id = "id"
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
        aCoder.encode(id, forKey: PropertyKey.id)
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
        
        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? String
            else
        {
            os_log("Unable to decode the name for a Night object.", log: OSLog.default, type: .debug)
            return nil
        }
        let eventStart = aDecoder.decodeObject(forKey: PropertyKey.eventStart)
        let eventEnd = aDecoder.decodeObject(forKey: PropertyKey.eventEnd)
        let alarmTime = aDecoder.decodeObject(forKey: PropertyKey.alarmTime)
        let motionEvents = aDecoder.decodeObject(forKey: PropertyKey.motionEvents)
        let lengthOfSleep = aDecoder.decodeObject(forKey: PropertyKey.lengthOfSleep)
        let sleepScore = aDecoder.decodeObject(forKey: PropertyKey.sleepScore)
        let deepSleepPercentage = aDecoder.decodeObject(forKey: PropertyKey.deepSleepPercentage)
        let lightSleepPercentage = aDecoder.decodeObject(forKey: PropertyKey.lightSleepPercentage)
        let awakePercentage = aDecoder.decodeObject(forKey: PropertyKey.awakePercentage)
        let userClassification = aDecoder.decodeObject(forKey: PropertyKey.userClassification) as? Int
        
        self.init(start: eventStart as! Date, end: eventEnd as! Date, alarm: alarmTime as! Date, events: motionEvents as! [Int], length: lengthOfSleep as! DateInterval, score: sleepScore as! Int, deepPer: deepSleepPercentage as! Double, lightPer: lightSleepPercentage as! Double, awakePer: awakePercentage as! Double, classification: userClassification)
            
    }
    
    init(start: Date, score: Int, classification: Int? = nil) {
        super.init()
        eventStart = start
        sleepScore = score
        userClassification = classification
    }
    init(start: Date, end: Date, alarm: Date, events: [Int], length: DateInterval, score: Int, deepPer: Double, lightPer: Double, awakePer: Double, classification: Int? = nil) {
        super.init()
        eventStart = start
        eventEnd = end
        alarmTime = alarm
        motionEvents = events
        lengthOfSleep = length
        sleepScore = score
        deepSleepPercentage = deepPer
        lightSleepPercentage = lightPer
        awakePercentage = awakePer
        userClassification = classification
    }
    
    
    
    // raw data values
    var id = String()
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
