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
    var dopplerBoi: BrightnessViewController = BrightnessViewController()

    var drPhill = DoctorPhill()
    let cmManager = CoreMotionManager()
    
    let notificationIdentifier = "myNotification"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var seconds: Double = 0.0
        if let k = alarmTime {
            seconds = handleTime(date: k)
            print("SECONDS", seconds)
            let duration = seconds
            self.notify(inSeconds: duration, completion: { success in
                if success {
                    print("successful scheduling")
                } else {
                    print("error scheduling")
                }
            })
        }
        UIApplication.shared.isIdleTimerDisabled = true
        UIApplication.shared.isStatusBarHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(deviceChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
//        self.screenOff.isHidden = true
//        self.screenOff.layer.zPosition = 1;
      
        drPhill.createNight(start: Date(), alarm: Date())
        cmManager.startReceivingAccelUpdates(interval: 0.1, completion:drPhill.HandleMotion)
        print("Started motion tracking")
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: "donePressed"), animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
//        self.screenOff.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
//        self.screenOff.isHidden = true
    }
    
    @objc func donePressed()
    {
        let temp = NightWatchman.init()
        temp.loadNights()
        
        var tempnight = drPhill.EndSession(end: Date())
        
        tempnight = SleepyBoye.analyzeNight(data: tempnight)
        
        temp.nights.append(tempnight)
        temp.saveNights()
        navigationController?.popViewController(animated: true)
        
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
        content.sound = UNNotificationSound.init(named: "dragon.caf")
        content.title = "ALARM"
        content.body = "Rise and shine! It's morning time!"
        print("inSeconds:", inSeconds)
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
    
    func handleTime(date: Date) -> Double {
        let currDate = Date()
        let calendar = Calendar.current
        let currYear = calendar.component(.year, from: currDate)
        let currMonth = calendar.component(.month, from: currDate)
        let currDay = calendar.component(.day, from: currDate)
        let currHour = calendar.component(.hour, from: currDate)
        let currMinute = calendar.component(.minute, from: currDate)
        let endHour = calendar.component(.hour, from: date)
        let endMinute = calendar.component(.minute, from: date)
        let components = DateComponents(year: 2017, month: currMonth, day: currDay, hour: endHour, minute: endMinute, second: 0)
        let alarm = calendar.date(from: components)
        let elapsedTime = alarm?.timeIntervalSinceNow
        if let moonDust = elapsedTime {
            if (moonDust < 0.0) {
                return (moonDust * -1)
            } else {
                return moonDust
            }
        }
        return 1.0
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        self.screenOff.isHidden = true
        UIApplication.shared.isIdleTimerDisabled = false
        UIApplication.shared.isStatusBarHidden = false
        
    }

}
