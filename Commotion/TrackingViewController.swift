//
//  TrackingViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit

class TrackingViewController: UIViewController {

    var drPhill = DoctorPhill()
    let cmManager = CoreMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }

}
