//
//  HomeViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func startTrackingClicked(_ sender: Any) {
        // create the alert
        let alert = UIAlertController(title: "Set Morning Alarm?", message: "Would you like to wake up to an alarm?", preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "Set Alarm", style: .default, handler: { action in
            let alarmVC = AlarmViewController()
            self.navigationController?.pushViewController(alarmVC, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No Alarm", style: .default, handler: { action in
            let trackingVC = TrackingViewController()
            self.navigationController?.pushViewController(trackingVC, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

}
