//
//  ViewController.swift
//  TableViewDemo
//
//  Created by guest2 on 16/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var movies = ["The Lion King", "The Incredibles", "Guardians of the Galaxy", "The Flash", "The Avengers", "The Dark Knight", "The Walking Dead", "Insidious", "Conguring"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func editAction(_ sender: UIBarButtonItem) {
        self.tableView.setEditing(!(tableView.isEditing), animated: true)
        
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = movies[indexPath.row]
        
        return cell
    }
}

