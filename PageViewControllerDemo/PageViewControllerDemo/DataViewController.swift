//
//  DataViewController.swift
//  PageViewControllerDemo
//
//  Created by Tee Shuwn Yuan on 23/08/2020.
//  Copyright © 2020 Tee Shuwn Yuan. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    var displayText: String?
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
