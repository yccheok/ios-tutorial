//
//  DashboardController.swift
//  TabDemo
//
//  Created by guest2 on 07/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class DashboardController: UIViewController, TabInfoable {
    @IBOutlet weak var label: UILabel?
    
    var tabInfo: TabInfo? = nil {
        didSet {
            updateLabel()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLabel()
    }
    
    private func updateLabel() {
        let n: String?
        switch (tabInfo?.type) {
        case .All:
            n = "All"
        case .Calendar:
            n = "Calendar"
        case .Settings:
            n = "Settings"
        default:
            n = tabInfo?.name
        }
        label?.text = "Dash \(n!)"
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
