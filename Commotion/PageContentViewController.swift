//
//  PageContentViewController.swift
//  Commotion
//
//  Created by Kellen Schmidt on 12/5/17.
//  Copyright © 2017 Eric Larson. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    var pageIndex: Int = 0
    var strTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        testLabel.text = strTitle
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
