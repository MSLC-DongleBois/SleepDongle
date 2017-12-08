//
//  TrackingViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit
import UserNotifications

class TrackingViewController: UIViewController {
    
    let currentBrightness = UIScreen.main.brightness
    var alarmTime: Date? = nil

    var drPhill = DoctorPhill()
    let cmManager = CoreMotionManager()
    
    let notificationIdentifier = "myNotification"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var dateStuff = DateComponents()
        let calendar = Calendar.current
        dateStuff.hour = calendar.component(.hour, from: alarmTime!)
        dateStuff.minute = calendar.component(.minute, from: alarmTime!)
        dateStuff.year = 2017
        print("DATESTUFF",dateStuff)
        let elapsed = 5
        let duration = Double(elapsed)
        self.notify(inSeconds: duration, completion: { success in
            if success {
                print("successful scheduling")
            } else {
                print("error scheduling")
            }
        })
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
    
    func notify(inSeconds: TimeInterval, completion: @escaping (Bool) -> ()) {
        // create notification content
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default()
        content.title = "ALARM"
        content.body = "Rise and shine! It's morning time!"
        print("inSeconds:",inSeconds)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        if let alarm = alarmTime {
            print(alarm)
            print("ALARM INITIALLY SET")
            let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                if error != nil {
                    print("ERROR w/ notification!")
                    completion(false)
                } else {
                    completion(true)
                }
            })
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        self.screenOff.isHidden = true
        UIApplication.shared.isIdleTimerDisabled = false
        UIApplication.shared.isStatusBarHidden = false
        
    }

}
