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

        // Load the sample data.
        loadSampleMeals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    private func loadSampleMeals() {
        var temp: NightyNight = NightyNight(start: Date(), score: 100, classification: 1)
        cellData.append(temp)
        temp = NightyNight(start: Date(), score: 69)
        cellData.append(temp)
        temp = NightyNight(start: Date(), score: 33)
        cellData.append(temp)
        
    }
    
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMM dd") // set template after setting locale
        return dateFormatter.string(from: date) // Monday, Dec 31
    }

}
