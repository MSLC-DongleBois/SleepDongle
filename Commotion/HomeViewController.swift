//
//  HomeViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var startTrackingButton: UIButton!
    @IBOutlet weak var sleepHistoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveSampleNights()

        // Do any additional setup after loading the view.
        startTrackingButton.layer.cornerRadius = 4
        sleepHistoryButton.layer.cornerRadius = 4
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
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
    
    private func saveSampleNights()
    {
        let night = NightWatchman()
        var temp: NightyNight = NightyNight(start: Date(timeIntervalSinceNow: -100000), end: Date(timeIntervalSinceNow: -80000), alarm: Date(), events: [20, 15, 10, 10, 9, 11, 7, 9, 14, 11, 6, 10, 10, 10, 10, 10, 10, 12, 8, 11, 9, 7, 6, 8, 8, 8, 5, 6, 7, 4, 3, 15, 2, 4, 5, 4, 0, 0, 1, 0, 2, 3, 2, 0, 4, 0, 1, 4], length: DateInterval(), score: 100, deepPer: 13.64, lightPer: 52.55, awakePer: 33.81, classification: 1)
        night.nights.append(temp)
        
        temp = NightyNight(start: Date(timeIntervalSinceNow: -50000), end: Date(timeIntervalSinceNow: -5000), alarm: Date(), events: [6, 7, 8, 9, 10, 11, 10, 10, 9, 9, 10, 12, 13, 14, 16, 18, 20, 19, 20, 10, 4, 4, 3, 4, 10, 9, 9, 10, 10, 12, 11, 11, 11, 9, 8, 9, 11, 12, 14, 13, 14, 14, 11, 10, 10, 12, 13, 15], length: DateInterval(), score: 1, deepPer: 71, lightPer: 22.90, awakePer: 6.1, classification: 2)
        night.nights.append(temp)
        
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [1, 2, 3], length: DateInterval(), score: 33, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 3)
        night.nights.append(temp)
        
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [1, 2, 3], length: DateInterval(), score: 55, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 3)
        night.nights.append(temp)
        
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [1, 2, 3], length: DateInterval(), score: 18, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 3)
        night.nights.append(temp)
        
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [1, 2, 3], length: DateInterval(), score: 97, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 3)
        night.nights.append(temp)
        
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [9,9,8,9,0,8,9,8,7,5,5,5,4,3,5,4,3,4,5,6,4,3,2,2,1,2,3,2,1,1,1,2,1,2,2,1,2,1,2,1,2,3,4,1,1,1,2,3,3,7,6,5,4,3,2,3,2,4,5,7,8,9,0,0,0,9,8,7,6,6,5,4,5,6,7,8,6,5,5,7,7,8], length: DateInterval(), score: 97, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 3)
        night.nights.append(temp)
        
        night.nights = SleepyBoye.analyzeNights(dataArray: night.nights)
        night.saveNights()
    }

}
