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
    
    // Will show drag button on the right, if we conform this method.
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObjTemp = movies[sourceIndexPath.item]
        movies.remove(at: sourceIndexPath.item)
        movies.insert(movedObjTemp, at: destinationIndexPath.item)
    }
    
    // Will show Delete button on the right, if we conform this method.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { 
        if editingStyle == .delete {
            movies.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = movies[indexPath.row]
        
        return cell
    }
    
    // MARK: Customization
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

