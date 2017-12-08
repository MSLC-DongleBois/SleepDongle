//
//  PageContentViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit
import Charts

class PageContentViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var barryBoi: BarChartView!
    
    var pageIndex: Int = 0
    var strTitle: String!
    var daysOfWeek: [String]!
    var rawData: [Double]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        testLabel.text = strTitle
        drawBarChart(xLabels: daysOfWeek, yValues: rawData, label: "Average sleep per night")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        let averageLine = ChartLimitLine(limit: averageVal)
        averageLine.lineColor = UIColor(red: 25/255, green: 91/255, blue: 218/255, alpha: 1)
        
        
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
        
        barryBoi.xAxis.granularityEnabled = true
        barryBoi.xAxis.granularity = 1
        
        self.barryBoi.rightAxis.addLimitLine(averageLine)
        self.barryBoi.animate(yAxisDuration: 0.5, easingOption: .easeInSine)
        
        self.barryBoi.data = chartData
        
    }

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
