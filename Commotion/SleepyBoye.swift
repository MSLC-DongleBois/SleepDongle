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
    
    static func analyzeNight(data: NightyNight)->NightyNight
    {
        var deepSleep: Int = 0
        var lightSleep: Int = 0
        var awake: Int = 0
        var numBuckets: Int = 0
        var deepSleepPercentage: Double!
        var lightSleepPercentage: Double!
        var awakePercentage: Double!
        var sleepScore: Int!
        
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
        
        return data
        
    }
    
    
}
