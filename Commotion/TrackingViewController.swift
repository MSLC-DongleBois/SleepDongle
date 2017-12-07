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

    var drPhill = DoctorPhill()
    let cmManager = CoreMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        UIApplication.shared.isIdleTimerDisabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(deviceChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        self.view.backgroundColor = UIColor.clear
      
        drPhill.createNight(start: Date(), alarm: Date())
        cmManager.startReceivingAccelUpdates(interval: 0.1, completion:drPhill.HandleMotion)
        print("Started motion tracking")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    @objc func deviceChange() {
        switch UIDevice.current.orientation {
        case .faceDown:
            UIScreen.main.brightness = CGFloat(0.0)
        case .faceUp:
            UIScreen.main.brightness = currentBrightness
        case .unknown:
            UIScreen.main.brightness = CGFloat(0.0)
        case .landscapeLeft:
            UIScreen.main.brightness = currentBrightness
        case .landscapeRight:
            UIScreen.main.brightness = currentBrightness
        case .portrait:
            UIScreen.main.brightness = currentBrightness
        case .portraitUpsideDown:
            UIScreen.main.brightness = currentBrightness
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }


}
