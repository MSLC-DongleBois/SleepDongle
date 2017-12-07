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
//        alarmTime = formatter.stringFromDate(time)
        setAlarmTime(hour: hour, minute: minute)
    }
    
    func timePickerDidClose(_ timePicker: DPTimePicker) {
        navigationController?.popViewController(animated: true)
    }
}

class AlarmViewController: UIViewController {
    
    @IBOutlet weak var alarmLabel: UILabel!
    
    let timePicker: DPTimePicker = DPTimePicker.timePicker()
    let mainColor = UIColor.green
    let accentColor = UIColor.black
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        
        timePicker.insertInView(view)
        timePicker.delegate = self
        timePicker.closeButton.setTitleColor(accentColor, for: .normal)
        timePicker.closeButton.setTitle("Cancel", for: .normal)
        timePicker.okButton.setTitleColor(accentColor, for: .normal)
        timePicker.okButton.setTitle("Set", for: .normal)
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
        timePicker.initialHour = "15"
        timePicker.initialMinute = "12"
        
        timePicker.show(nil)
    }
    
    func setAlarmTime(hour: String, minute: String) {
        alarmLabel.text = "\(hour):\(minute)"
    }
    
}
