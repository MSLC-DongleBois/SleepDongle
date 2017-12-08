//
//  TrackingViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit
import Charts

class TrackingViewController: UIViewController {
    
    @IBOutlet weak var chartyBoi: LineChartView!
    
    
    @IBOutlet weak var barryBoi: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        
        let rawData = [7.0, 7.2, 6.0, 5.1, 7.2, 9.5, 8.2]
        
        drawBarChart(xLabels: daysOfWeek, yValues: rawData, label: "Average sleep per night")
        
        drawNightlyGraph()
        
        // Do any additional setup after loading the view.
    }
    
    func drawBarChart(xLabels: [String], yValues: [Double], label: String) {
        
        // Set graph's bar color value
        let barColor = [UIColor(red: 83/255, green: 200/255, blue: 240/255, alpha: 1)]
        
        var averageVal: Double = 0
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0 ..< xLabels.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
            averageVal += yValues[i]
        }
        averageVal = averageVal / Double(yValues.count)
        averageVal = Double(round(averageVal * 100)/100)
        let averageLabel = "Average: " + String(averageVal)
        let averageLine = ChartLimitLine(limit: averageVal, label: averageLabel)
        averageLine.lineColor = UIColor(red: 25/255, green: 91/255, blue: 218/255, alpha: 1)
        averageLine.valueTextColor = UIColor.white
        averageLine.labelPosition = .rightBottom
        
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: label)
        chartDataSet.valueTextColor = UIColor.white
        chartDataSet.valueFont = .systemFont(ofSize: 11)
        chartDataSet.colors = barColor
        let chartData = BarChartData(dataSet: chartDataSet)
        
        let chartFormatter = BarChartFormatter(labels: xLabels)
        self.barryBoi.xAxis.valueFormatter = chartFormatter
        
        
        // Labels
        self.barryBoi.xAxis.labelTextColor = UIColor.white
        self.barryBoi.leftAxis.labelTextColor = UIColor.white
        
        // Y-Axis
        barryBoi.leftAxis.drawGridLinesEnabled = false
        barryBoi.rightAxis.drawGridLinesEnabled = false
        barryBoi.rightAxis.drawAxisLineEnabled = false
        barryBoi.rightAxis.drawLabelsEnabled = false
        barryBoi.leftAxis.drawAxisLineEnabled = false
        barryBoi.leftAxis.drawLabelsEnabled = false
        
        // Get rid of legend and description
        barryBoi.chartDescription?.text = ""
        barryBoi.legend.enabled = false
        
        // X Axis
        barryBoi.xAxis.drawGridLinesEnabled = false
        barryBoi.xAxis.drawAxisLineEnabled = true
        barryBoi.xAxis.axisLineWidth = 2
        barryBoi.xAxis.axisLineColor = UIColor.white
        barryBoi.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barryBoi.xAxis.drawLabelsEnabled = true
        barryBoi.xAxis.labelFont = .boldSystemFont(ofSize: 13)
        
        
        self.barryBoi.rightAxis.addLimitLine(averageLine)
        self.barryBoi.animate(yAxisDuration: 0.5, easingOption: .easeInSine)
        
        self.barryBoi.data = chartData
        
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

private class BarChartFormatter: NSObject, IAxisValueFormatter {
    
    var labels: [String] = []
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels[Int(value)]
    }
    
    init(labels: [String]) {
        super.init()
        self.labels = labels
    }
}
