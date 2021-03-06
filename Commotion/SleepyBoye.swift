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
    
    static func analyzeNight(data: NightyNight) -> NightyNight {
        var deepSleep: Int = 0
        var lightSleep: Int = 0
        var awake: Int = 0
        var numBuckets: Int = 0
        var deepSleepPercentage: Double!
        var lightSleepPercentage: Double!
        var awakePercentage: Double!
        var sleepScore: Int!
        var lengthOfSleep: DateInterval!
        
        for event in data.motionEvents {
            if event < 5 {
                deepSleep = deepSleep + 1
            }
            else if event < 7 {
                lightSleep = lightSleep + 1
            }
            else {
                awake = awake + 1
            }
            
            numBuckets = numBuckets + 1
        }
        
        lengthOfSleep = DateInterval(start: data.eventStart, end: data.eventEnd)
        data.lengthOfSleep = lengthOfSleep
        
        deepSleepPercentage = Double(deepSleep) / Double(numBuckets)
        lightSleepPercentage = Double(lightSleep) / Double(numBuckets)
        awakePercentage = Double(awake) / Double(numBuckets)
        
        data.deepSleepPercentage = deepSleepPercentage
        data.lightSleepPercentage = lightSleepPercentage
        data.awakePercentage = awakePercentage
        
        sleepScore = 100
        
        sleepScore = sleepScore - (awake * 2)
        sleepScore = sleepScore - Int(lightSleep / 2)
        if (sleepScore < deepSleep)
        {
            sleepScore = deepSleep
        }
        
        data.sleepScore = sleepScore
        
        if (data.userClassification == nil)
        {
            data.userClassification = 1
        }
        
        return data
    }
    
    static func analyzeNights(dataArray: [NightyNight]) -> [NightyNight] {
        var analyzedNights: [NightyNight] = [NightyNight]()
        for night in dataArray {
            analyzedNights.append(SleepyBoye.analyzeNight(data: night))
        }
        return analyzedNights
    }
    
}
