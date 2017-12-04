//
//  CoreMotionManager.swift
//  Commotion
//
//  Created by Kevin Queenan on 12/4/17.
//  Copyright © 2017 Eric Larson. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

class CoreMotionManager: NSObject {
    
    let manager = CMMotionManager()
    static var instance: CoreMotionManager?
    
    class func sharedManager() -> CoreMotionManager {
        if (instance == nil) {
            instance = CoreMotionManager()
        }
        return instance!
    }
    
    func startReceivingAccelUpdates(interval: TimeInterval, completion: ((CMAccelerometerData?, NSError?) -> Void)!) {
        if (manager.isAccelerometerAvailable) {
            manager.stopAccelerometerUpdates()
            manager.accelerometerUpdateInterval = interval
            manager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: {
                data, error in
                if let callback = completion { callback(data, error as NSError?) }
            })
        }
    }
    
    func stopReceivingAccelUpdates(completion: (() -> Void)!) {
        if (manager.isAccelerometerAvailable) {
            manager.stopAccelerometerUpdates()
            if let callback = completion { callback() }
        }
    }
    
}
