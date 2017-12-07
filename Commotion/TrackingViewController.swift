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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color of view
        self.view.backgroundColor = UIColor.brown
        
        // Set color gradient values
        let topGradient = UIColor.init(red: 66/255, green: 244/255, blue: 78/255, alpha: 1).cgColor
        let bottomGradient = UIColor.init(red: 107/255, green: 255/255, blue: 116/255, alpha: 0.7).cgColor
        let gradientColors = [topGradient, bottomGradient] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        
        // Set graph's line color value
        let lineColor = UIColor.init(red: 0/255, green: 244/255, blue: 17/255, alpha: 1)
        
        
        // Set dummy data
        let dollars1 = [20.0, 15.0, 10.0, 10.0, 9.0, 11.0, 7.0, 9.0, 14.0, 11.0, 6.0, 3.0,
                        20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0,
                        20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0,
                        20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0,
                        20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0,
                        20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0,
                        20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0,
                        20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        
        
        // Creating an array of data entries
        var yValues : [ChartDataEntry] = [ChartDataEntry]()
        
        for i in 0 ..< dollars1.count {
            yValues.append(ChartDataEntry(x: Double(i + 1), y: dollars1[i]))
        }
        
        let data = LineChartData()
        
        let ds = LineChartDataSet(values: yValues, label: "Months")
        
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
        chartyBoi.leftAxis.drawLabelsEnabled = true
        
        // Get rid of legend and description
        chartyBoi.chartDescription?.text = ""
        chartyBoi.legend.enabled = false
        
        // X Axis
        chartyBoi.xAxis.drawGridLinesEnabled = false
        chartyBoi.xAxis.drawAxisLineEnabled = true
        chartyBoi.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartyBoi.xAxis.drawLabelsEnabled = true
        chartyBoi.xAxis.labelTextColor = UIColor.white
        
        
//        let quality = ["Awake", "Asleep", "Deep Sleep"]
        let hours = ["12am", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am"]
        //self.chartyBoi.xAxis.valueFormatter = IndexAxisValueFormatter(values: hours)
        
//
//        chartyBoi.xAxis.valueFormatter = IndexAxisValueFormatter(values: hours)
//        chartyBoi.leftAxis.valueFormatter = IndexAxisValueFormatter(values: quality)
//        chartyBoi.xAxis.granularity = 1
//        chartyBoi.leftAxis.granularity = 1
        
        
        chartyBoi.animate(yAxisDuration: 0.5, easingOption: .easeInCubic)
        data.addDataSet(ds)
        self.chartyBoi.data = data
    
        // Do any additional setup after loading the view.
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
