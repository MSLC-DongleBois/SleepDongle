//
//  HistoryItemViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit

class HistoryItemViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userClassificationSegmentedControl: UISegmentedControl!
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var cellData: NightyNight?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set up views if editing an existing Meal.
        if let cellData = cellData {
            scoreLabel.text = String(cellData.sleepScore)
            dateLabel.text = convertDateToString(date: cellData.eventStart)
            userClassificationSegmentedControl.selectedSegmentIndex = cellData.userClassification!
        }
    }

    @IBAction func userClassificationValueChanged(_ sender: UISegmentedControl) {
        cellData?.userClassification = sender.selectedSegmentIndex
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM dd, YYYY") // set template after setting locale
        return dateFormatter.string(from: date) // December 31, 2017
    }

}
