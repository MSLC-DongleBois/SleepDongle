//
//  NightyNight.swift
//  Commotion
//
//  Created by Logan Dorsey on 12/5/17.
//  Copyright © 2017 Eric Larson. All rights reserved.
//

import Foundation

class NightyNight : NSObject
{
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
