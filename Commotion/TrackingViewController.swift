//
//  TrackingViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit

class TrackingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(deviceChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc func deviceChange() {
        print("WE GOT HERE TIM COOK FUCKING ASSHOLE")
        switch UIDevice.current.orientation {
        case .faceDown:
            print("DOWN YOU PIECE OF SHIT FUCK YOU SWIFT 4")
        case .faceUp:
            print("UPPPPPPPP!")
        case .unknown:
            print("unknown")
        case .landscapeLeft:
            print()
        case .landscapeRight:
            print()
        case .portrait:
            print()
        case .portraitUpsideDown:
            print()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
