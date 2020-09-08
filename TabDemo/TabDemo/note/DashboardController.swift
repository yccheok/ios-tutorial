//
//  DashboardController.swift
//  TabDemo
//
//  Created by guest2 on 07/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class DashboardController: UIViewController, PageIndexable {
    @IBOutlet weak var label: UILabel?
    
    var pageIndex = -1 {
        didSet {
            updateLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLabel()
    }
    
    private func updateLabel() {
        label?.text = "Dash \(pageIndex)"
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
