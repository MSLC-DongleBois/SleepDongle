//
//  HistoryTableViewController.swift
//  SleepDongle
//
//  Created by Kellen Schmidt on 11/21/17.
//  Copyright © 2017 Kellen Schmidt. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var cellData = [NightyNight]()

    override func viewDidLoad() {
        super.viewDidLoad()

        saveSampleNights()
        // Load the sample data.
        loadNights()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "HistoryTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HistoryTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HistoryTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let singleCellData = cellData[indexPath.row]
        
        // Configure the cell...
        cell.scoreLabel.text = String(singleCellData.sleepScore)
        cell.dateLabel.text = convertDateToString(date: singleCellData.eventStart)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let good = UITableViewRowAction(style: .normal, title: "Good") { action, index in
            print("Good button tapped")
            self.cellData[index.row].userClassification = 2 // 2: "Good"
        }
        good.backgroundColor = .green
        
        let neutral = UITableViewRowAction(style: .normal, title: "Neutral") { action, index in
            print("Neutral button tapped")
            self.cellData[index.row].userClassification = 1 // 1: "Neutral"
        }
        neutral.backgroundColor = .orange
        
        let poor = UITableViewRowAction(style: .normal, title: "Poor") { action, index in
            print("Poor button tapped")
            self.cellData[index.row].userClassification = 0 // 0: "Poor"
        }
        poor.backgroundColor = .red
        
        return [good, neutral, poor]
    }

    // MARK: Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)

        guard let historyDetailViewController = segue.destination as? HistoryItemViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedHistoryCell = sender as? HistoryTableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedHistoryCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        let selectedCellData = cellData[indexPath.row]
        historyDetailViewController.cellData = selectedCellData

    }
    
    //MARK: Private Methods
    
    private func saveSampleNights()
    {
        let night = NightWatchman()
        var temp: NightyNight = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [20, 15, 10, 10, 9, 11, 7, 9, 14, 11, 6, 10, 10, 10, 10, 10, 10, 12, 8, 11, 9, 7, 6, 8, 8, 8, 5, 6, 7, 4, 3, 15, 2, 4, 5, 4, 0, 0, 1, 0, 2, 3, 2, 0, 4, 0, 1, 4], length: DateInterval(), score: 69, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 1)
        night.nights.append(temp)
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [6, 7, 8, 9, 10, 11, 10, 10, 9, 9, 10, 12, 13, 14, 16, 18, 20, 19, 20, 10, 4, 4, 3, 4, 10, 9, 9, 10, 10, 12, 11, 11, 11, 9, 8, 9, 11, 12, 14, 13, 14, 14, 11, 10, 10, 12, 13, 15], length: DateInterval(), score: 1, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 2)
        night.nights.append(temp)
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [1, 2, 3], length: DateInterval(), score: 33, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 3)
        night.nights.append(temp)
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [1, 2, 3], length: DateInterval(), score: 55, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 3)
        night.nights.append(temp)
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [1, 2, 3], length: DateInterval(), score: 18, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 3)
        night.nights.append(temp)
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [1, 2, 3], length: DateInterval(), score: 97, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 3)
        night.nights.append(temp)
        temp = NightyNight(start: Date(), end: Date(), alarm: Date(), events: [1, 2, 3], length: DateInterval(), score: 81, deepPer: 69.69, lightPer: 69.69, awakePer: 69.69, classification: 3)
        night.nights.append(temp)
        
        night.saveNights()
    }
    
    private func loadNights() {
        let night = NightWatchman()
        night.loadNights()
        for x in night.nights
        {
            cellData.append(x)
        }
        
    }
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMM dd") // set template after setting locale
        return dateFormatter.string(from: date) // Monday, Dec 31
    }

}
