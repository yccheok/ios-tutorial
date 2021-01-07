//
//  ColorPickerViewController.swift
//  experiment-subview
//
//  Created by Cheok Yan Cheng on 06/01/2021.
//

import UIKit

class ColorPickerViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var pages = [UIView?](repeating: nil, count: 2)
    var klasses = [PresetColorView.self, CustomColorView.self]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        /**
        Setup the initial scroll view content size and first pages only once.
        (Due to this function called each time views are added or removed).
        */
        _ = setupInitialPages
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }

    fileprivate func removeAllPages() {
        for page in pages where page != nil {
            page?.removeFromSuperview()
        }
        
        pages[0] = nil
        pages[1] = nil
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil) { _ in
            // Clear out and reload the relevant pages.
            self.removeAllPages()

            // Adjust the scroll view's contentSize (larger or smaller) depending on the new transition size.
            self.adjustScrollView()
            
            self.loadPage(0)
            self.loadPage(1)
        }
    }
    
    /// Readjust the scroll view's content size in case the layout has changed.
    fileprivate func adjustScrollView() {
        scrollView.contentSize =
            CGSize(width: scrollView.bounds.width * CGFloat(pages.count),
                   height: scrollView.bounds.height)
    }
    
    fileprivate func loadPage(_ page: Int) {
        guard page < pages.count && page >= 0 else { return }
        
        if pages[page] == nil {
            let klass = klasses[page]
            let name = String(describing: klass)
            
            guard let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: self, options: nil)[0] as? UIView else {
                return
            }

            var frame = scrollView.bounds
            // Offset the frame's X origin to its correct page offset.
            frame.origin.x = frame.width * CGFloat(page)
            
            view.frame = frame
            scrollView.addSubview(view)
 
            pages[page] = view
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
    
    lazy var setupInitialPages: Void = {
        /**
        Setup our initial scroll view content size and first pages once.
        
        Layout the scroll view's content size after we have knowledge of the topLayoutGuide dimensions.
        Each page is the width and height of the scroll view's frame.
        
        Note: Set the scroll view's content size to take into account the top layout guide.
        */
        adjustScrollView()
        
        // Pages are created on demand, load the visible page and next page.
        loadPage(0)
        loadPage(1)
    }()
}
