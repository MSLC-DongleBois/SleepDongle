//
//  PageViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var arrPageTitle: NSArray = NSArray()
    var xValues: [String] = [String]()
    var yValues: [Double] = [Double]()
    var newXVals: [String] = [String]()
    var yValScores: [Double] = [Double]()
    var yValLengths: [Double] = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Load data
        arrPageTitle = ["Sleep Duration", "Sleep Score"];
        xValues = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        yValues = [7.0, 7.2, 6.0, 5.1, 7.2, 9.5, 8.2, 69, 14, 88, 43, 97, 32, 8]
        
        let night = NightWatchman()
        let nights = night.loadNights()
        let mostRecentNight = night.getLatestNight()
        let lastWeekday = getWeekdayFrom(date: mostRecentNight.eventStart)
        let xValueIndex = xValues.index(of: lastWeekday)
        newXVals = Array(xValues[(xValueIndex! + 1) ..< (xValueIndex! + 8)])
        let sortedNights = nights?.sorted { $0.eventStart < $1.eventStart }
        var lastSevenNights = [NightyNight]()
        if((sortedNights?.count)! > 6) {
            lastSevenNights = Array(sortedNights![((sortedNights?.count)! - 7) ..< (sortedNights?.count)!])
        } else {
            lastSevenNights = Array(sortedNights![0 ..< (sortedNights?.count)!])
        }
        yValScores = getScoresFrom(nights: lastSevenNights)
        yValLengths = getLengthsFrom(nights: lastSevenNights)
        
        
        self.dataSource = self
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        self.view.backgroundColor = UIColor.black
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index = index - 1
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        var index = pageContent.pageIndex
        if (index == NSNotFound)
        {
            return nil
        }
        index = index + 1
        if (index == arrPageTitle.count)
        {
            return nil;
        }
        return getViewControllerAtIndex(index: index)
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> PageContentViewController
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        pageContentViewController.strTitle = "\(arrPageTitle[index])"
        pageContentViewController.daysOfWeek = newXVals
        if(index == 0) {
            pageContentViewController.rawData = yValLengths
        } else {
            pageContentViewController.rawData = yValScores
        }
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getWeekdayFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE") // set template after setting locale
        return dateFormatter.string(from: date) // Wed
    }
    
    func getScoresFrom(nights: [NightyNight]) -> [Double] {
        var scores: [Double] = [Double]()
        for night in nights {
            scores.append(Double(night.sleepScore))
        }
        return scores
    }
    
    func getLengthsFrom(nights: [NightyNight]) -> [Double] {
        var scores: [Double] = [Double]()
        for night in nights {
            let seconds = night.lengthOfSleep.duration
            print("Seconds: \(seconds)")
            let hours = Double(seconds) / 3600.0
            scores.append(hours)
        }
        return scores
    }

}
