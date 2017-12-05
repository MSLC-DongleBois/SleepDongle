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
    
    
    func createNight(start: Date, alarm: Date)
    {
        
    }
    
    func HandleMotion(data: CMAccelerometerData?, error: NSError?)
    {
        
    }
    
    func EndSession(end: Date) -> NightyNight
    {
        return NightyNight()
    }
    
}
