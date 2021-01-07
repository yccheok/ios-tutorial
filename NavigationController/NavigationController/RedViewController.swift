//
//  RedViewController.swift
//  NavigationController
//
//  Created by Cheok Yan Cheng on 02/01/2021.
//

import UIKit

class RedViewController: UIViewController {

    private var originalSize: CGSize?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Red"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.originalSize == nil {
                let originalSize = self.view.frame.size
                self.originalSize = originalSize
                self.view.frame.size = CGSize(
                    width: originalSize.width,
                    height: originalSize.height - keyboardSize.height
                )
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let originalSize = self.originalSize {
            self.view.frame.size = originalSize
            self.originalSize = nil
        }
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
