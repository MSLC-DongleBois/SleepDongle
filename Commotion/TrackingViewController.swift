//
//  TrackingViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit

class TrackingViewController: UIViewController {
    
    let currentBrightness = UIScreen.main.brightness
    var alarmTime: Date? = nil

    var drPhill = DoctorPhill()
    let cmManager = CoreMotionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Alarm time: \(alarmTime)")
      
        UIApplication.shared.isIdleTimerDisabled = true
        UIApplication.shared.isStatusBarHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(deviceChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        //self.view.backgroundColor = UIColor.clear
        
//        self.screenOff.isHidden = true
//        self.screenOff.layer.zPosition = 1;
      
        drPhill.createNight(start: Date(), alarm: Date())
        cmManager.startReceivingAccelUpdates(interval: 0.1, completion:drPhill.HandleMotion)
        print("Started motion tracking")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
//        self.screenOff.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
//        self.screenOff.isHidden = true
    }
    
    @objc func deviceChange() {
        switch UIDevice.current.orientation {
        case .faceDown:
            UIScreen.main.brightness = CGFloat(0.0)
//            self.screenOff.isHidden = false
            UIApplication.shared.isStatusBarHidden = true
        case .faceUp:
            UIScreen.main.brightness = currentBrightness
//            self.screenOff.isHidden = true
            UIApplication.shared.isStatusBarHidden = false
        case .unknown:
            UIScreen.main.brightness = CGFloat(0.0)
//            self.screenOff.isHidden = false
            UIApplication.shared.isStatusBarHidden = true
        case .landscapeLeft:
            UIScreen.main.brightness = currentBrightness
//            self.screenOff.isHidden = true
            UIApplication.shared.isStatusBarHidden = false
        case .landscapeRight:
            UIScreen.main.brightness = currentBrightness
//            self.screenOff.isHidden = true
            UIApplication.shared.isStatusBarHidden = false
        case .portrait:
            UIScreen.main.brightness = currentBrightness
//            self.screenOff.isHidden = true
            UIApplication.shared.isStatusBarHidden = false
        case .portraitUpsideDown:
            UIScreen.main.brightness = currentBrightness
//            self.screenOff.isHidden = true
            UIApplication.shared.isStatusBarHidden = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        self.screenOff.isHidden = true
        UIApplication.shared.isIdleTimerDisabled = false
        UIApplication.shared.isStatusBarHidden = false
        
    }

}
