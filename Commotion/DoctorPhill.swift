//
//  DoctorPhill.swift
//  Commotion
//
//  Created by Logan Dorsey on 12/5/17.
//  Copyright © 2017 Eric Larson. All rights reserved.
//

import Foundation
import CoreMotion

class DoctorPhill : NSObject
{
    
    var tonight = NightyNight()
    var accelX = 0.0
    var accelY = 0.0
    var accelZ = 0.0
    let motionThreshold = 0.2
    var itterCount = 0
    let itterThreshold = 300
    var cooldown = 0;
    var motionCount = 0;
    
    
    func createNight(start: Date, alarm: Date)
    {
        
        
    }
    
    func HandleMotion(data: CMAccelerometerData?, error: NSError?)
    {
        if (cooldown > 0)
        {
            cooldown = cooldown - 1
        }
        if (data != nil)
        {
            // first attempt at low pass filtering
            let RC = 0.15
            // same value as interval
            let dt = 0.1
            let alpha = dt / (RC + dt)
            let rawX = data?.acceleration.x
            let rawY = data?.acceleration.y
            let rawZ = data?.acceleration.z
            self.accelX = rawX! * alpha + (1.0 - alpha) * self.accelX
            self.accelY = rawY! * alpha + (1.0 - alpha) * self.accelY
            self.accelZ = rawZ! * alpha + (1.0 - alpha) * self.accelZ
        }
        let combinedMotion = self.accelX + self.accelY + self.accelZ
        if (combinedMotion > motionThreshold && cooldown == 0)
        {
            cooldown = 5
            motionCount = motionCount + 1
        }
        if (itterCount >= itterThreshold)
        {
            tonight.motionEvents.append(motionCount)
            motionCount = 0
            itterCount = 0
        }
        else
        {
            itterCount = itterCount + 1
        }
        
    }
    
    func EndSession(end: Date) -> NightyNight
    {
        return NightyNight()
    }
    
}
