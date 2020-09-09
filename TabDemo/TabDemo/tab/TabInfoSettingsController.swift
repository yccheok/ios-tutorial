//
//  TabInfoSettingsController.swift
//  TabDemo
//
//  Created by guest2 on 08/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class TabInfoSettingsController: UIViewController, TabInfoable {
    @IBOutlet weak var label: UILabel!
    
    @IBAction func button_click(_ sender: Any) {
        if let parent = self.parent?.parent as? ViewController {
            parent.debug()
        }
    }
    
    var tabInfo: TabInfo? = nil {
        didSet {
            updateLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateLabel()
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
    
    private func updateLabel() {
        label?.text = "\((tabInfo?.getPageTitle())!)"
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
