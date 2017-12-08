//
//  HistoryItemViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit
import Charts

class HistoryItemViewController: UIViewController {

    @IBOutlet weak var chartyBoi: LineChartView!
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
        
        drawNightlyGraph()

        // Do any additional setup after loading the view.
        
        // Set up views if editing an existing Meal.
        if let cellData = cellData {
            scoreLabel.text = String(cellData.sleepScore)
            dateLabel.text = convertDateToString(date: cellData.eventStart)
            if let userClassification = cellData.userClassification {
                userClassificationSegmentedControl.selectedSegmentIndex = userClassification
            } else {
                userClassificationSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
            }
        }
    }

    @IBAction func userClassificationValueChanged(_ sender: UISegmentedControl) {
        cellData?.userClassification = sender.selectedSegmentIndex
    }
    
    func drawNightlyGraph() {
        // Set background color of view
        self.view.backgroundColor = UIColor.black
        
        // Set color gradient values
        let topGradient = UIColor.init(red: 66/255, green: 244/255, blue: 78/255, alpha: 1).cgColor
        let bottomGradient = UIColor.init(red: 107/255, green: 255/255, blue: 116/255, alpha: 0.7).cgColor
        let gradientColors = [topGradient, bottomGradient] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        
        // Set graph's line color value
        let lineColor = UIColor.init(red: 0/255, green: 244/255, blue: 17/255, alpha: 1)
        
        // Set dummy data
        let sleepMovements = [20.0, 15.0, 10.0, 10.0, 9.0, 11.0, 7.0, 9.0, 14.0, 11.0, 6.0, 10,
                              10, 10, 10, 10, 10, 12, 8, 11, 9, 7, 6, 8,
                              8, 8, 5, 6, 7, 4, 3, 15, 2.0, 4.0, 5.0, 4.0,
                              0, 0, 1, 0, 2, 3, 2, 0, 4, 0, 1, 4,
                              6, 7, 8, 9, 10, 11, 10, 10, 9, 9, 10, 12,
                              13, 14, 16, 18, 20, 19, 20, 10, 4, 4.0, 3, 4.0,
                              10, 9, 9, 10, 10, 12, 11, 11, 11, 9, 8, 9,
                              11, 12, 14, 13, 14, 14, 11, 10, 10, 12, 13, 15]
        
        //        let sleepMovements = [20.0, 15.0, 10.0, 10.0, 9.0, 11.0, 7.0, 9.0, 14.0, 11.0, 6.0, 10,
        //                              10, 10, 10, 10, 10, 12, 8, 11, 9, 7, 6, 8,
        //                              8]
        
        var startSleep = 3;
        //
        //        // Format label strings
        //
        //
        //
        var tempString = "";
        var hours: [String] = [];
        var currCount = 0;
        
        for i in 0 ..< sleepMovements.count {
            if (currCount % 12 == 0) {
                if (startSleep == 12) {
                    tempString = "12pm"
                } else if (startSleep == 0) {
                    tempString = "12am"
                } else if (startSleep >= 13) {
                    tempString = String(startSleep - 12) + "pm"
                } else {
                    tempString = String(startSleep) + "am"
                }
                
                hours.append(tempString)
                startSleep += 1
                
                if (startSleep == 24) {
                    startSleep = 0
                }
                print(tempString)
            } else {
                hours.append("")
                print(currCount)
            }
            
            currCount += 1
        }
        
        print(hours)
        
        
        
        //let hours = ["12am", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am"]
        //        let hours = ["12am", "", "", "", "", "", "", "", "", "", "", "",
        //                              "1am", "", "", "", "", "", "", "", "", "", "", "",
        //                              "2am", "", "", "", "", "", "", "", "", "", "", "",
        //                              "3am", "", "", "", "", "", "", "", "", "", "", "",
        //                              "4am", "", "", "", "", "", "", "", "", "", "", "",
        //                              "5am", "", "", "", "", "", "", "", "", "", "", "",
        //                              "6am", "", "", "", "", "", "", "", "", "", "", "",
        //                              "7am", "", "", "", "", "", "", "", "", "", "", ""]
        
        // Creating an array of data entries
        var graphValues: [ChartDataEntry] = []
        
        for i in 0 ..< sleepMovements.count {
            let dataEntry = ChartDataEntry(x: Double(i + 1), y: Double(sleepMovements[i]))
            graphValues.append(dataEntry)
        }
        
        
        let ds = LineChartDataSet(values: graphValues, label: "Months")
        let data = LineChartData(dataSet: ds)
        
        let chartFormatter = IndexAxisValueFormatter(values: hours)
        
        self.chartyBoi.xAxis.valueFormatter = chartFormatter
        
        ds.setColor(lineColor)
        
        ds.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        
        ds.drawFilledEnabled = true // Draw the Gradient
        
        // Chart Styling
        ds.mode = .cubicBezier
        ds.drawCirclesEnabled = false
        ds.drawValuesEnabled = false
        
        // Get rid of y axis stuff
        chartyBoi.leftAxis.drawGridLinesEnabled = false
        chartyBoi.rightAxis.drawGridLinesEnabled = false
        chartyBoi.rightAxis.drawAxisLineEnabled = false
        chartyBoi.rightAxis.drawLabelsEnabled = false
        chartyBoi.leftAxis.drawLabelsEnabled = false
        chartyBoi.leftAxis.labelTextColor = UIColor.white
        
        // Get rid of legend and description
        chartyBoi.chartDescription?.text = ""
        chartyBoi.legend.enabled = false
        
        // X Axis
        chartyBoi.xAxis.drawGridLinesEnabled = false
        chartyBoi.xAxis.drawAxisLineEnabled = true
        chartyBoi.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartyBoi.xAxis.drawLabelsEnabled = true
        chartyBoi.xAxis.labelFont = .systemFont(ofSize: 11)
        chartyBoi.xAxis.labelTextColor = UIColor.white
        
        // LABELS: X AXIS
        self.chartyBoi.xAxis.centerAxisLabelsEnabled = true
        self.chartyBoi.xAxis.setLabelCount(hours.count, force: false)
        self.chartyBoi.xAxis.avoidFirstLastClippingEnabled = false
        self.chartyBoi.xAxis.granularityEnabled = true
        self.chartyBoi.xAxis.granularity = 1
        
        
        
        // Animate the drawing of the chart
        chartyBoi.animate(yAxisDuration: 0.5, easingOption: .easeInCubic)
        
        //data.addDataSet(ds)
        self.chartyBoi.data = data
        
        
        
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
