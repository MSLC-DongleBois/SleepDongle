//
//  AlarmViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit

var alarmTime: Date = Date()

extension AlarmViewController: DPTimePickerDelegate {
    func timePickerDidConfirm(_ hour: String, minute: String, timePicker: DPTimePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        alarmTime = formatter.date(from: "\(hour):\(minute)")!
        
        let trackingVC = TrackingViewController.init()
        
        trackingVC.alarmTime = alarmTime
        
        self.navigationController?.pushViewController(trackingVC, animated: true)
        //self.performSegue(withIdentifier: "TrackSegue", sender: self)
        
        
        
    }
    
    func timePickerDidClose(_ timePicker: DPTimePicker) {
        navigationController?.popViewController(animated: true)
    }
}

class AlarmViewController: UIViewController {

    let timePicker: DPTimePicker = DPTimePicker.timePicker()
    let mainColor = UIColor(red: 25/255, green: 91/255, blue: 218/255, alpha: 1.0)
    let accentColor = UIColor.black
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        timePicker.insertInView(view)
        timePicker.delegate = self
        timePicker.closeButton.setTitleColor(accentColor, for: .normal)
        timePicker.closeButton.setTitle("Cancel", for: .normal)
        timePicker.okButton.setTitleColor(accentColor, for: .normal)
        timePicker.okButton.setTitle("Start", for: .normal)
        timePicker.backgroundColor = mainColor
        timePicker.numbersColor = accentColor
        timePicker.linesColor = accentColor
        timePicker.pointsColor = accentColor
        timePicker.topGradientColor = mainColor
        timePicker.bottomGradientColor = mainColor
        timePicker.fadeAnimation = true
        timePicker.springAnimations = true
        timePicker.scrollAnimations = true
        timePicker.areLinesHidden = false
        timePicker.arePointsHidden = false
        timePicker.initialHour = "12"
        timePicker.initialMinute = "30"
        
        timePicker.show(nil)
    }
    
}
