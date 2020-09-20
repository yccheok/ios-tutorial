//
//  ViewController.swift
//  TableViewDemo2
//
//  Created by guest2 on 20/09/2020.
//

import UIKit

class ViewController: UIViewController {
    private static let tableViewItemCellClassName = String(describing: TableViewItemCell.self)
    private static let tableViewFooterCellClassName = String(describing: TableViewFooterCell.self)

    @IBOutlet weak var tableView: UITableView!
    
    var movies = ["The Lion King", "The Incredibles", "Guardians of the Galaxy", "The Flash", "The Avengers", "The Dark Knight", "The Walking Dead", "Insidious", "Conguring"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        tableView.register(
            UINib(nibName: ViewController.tableViewItemCellClassName, bundle: nil),
            forCellReuseIdentifier: ViewController.tableViewItemCellClassName
        )
        
        tableView.register(
            UINib(nibName: ViewController.tableViewFooterCellClassName, bundle: nil),
            forHeaderFooterViewReuseIdentifier: ViewController.tableViewFooterCellClassName
        )
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = tableView.dequeueReusableCell(withIdentifier: ViewController.tableViewItemCellClassName, for: indexPath) as? TableViewItemCell {
            item.textField?.text = movies[indexPath.row]
            return item
        }

        return TableViewItemCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: ViewController.tableViewFooterCellClassName) as? TableViewFooterCell {
            return footer
        }

       return nil
    }
}
