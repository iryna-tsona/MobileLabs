//
//  TasksTableViewController.swift
//  HealthyLifestyle
//
//  Created by Ірина Цьона on 3/23/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit
import Firebase

class TasksTableViewController: UITableViewController {
    
    var tasksCompletion = [FireTask]()
    var tasks = ["run", "squatting", "crunch", "push-ups", "step-ups"]
//    var tasksImage = ["run", "squatting.jpg"]
    var ref: DatabaseReference!
    
    override func viewWillAppear(_ animated: Bool) {
        self.ref.observe(.value) {[weak self] (snapshot) in
            var _tasksCompletion = [FireTask]()
            for item in snapshot.children {
                let taskCompletion = FireTask(snapshot: item as! DataSnapshot)
                _tasksCompletion.append(taskCompletion)
            }
            self?.tasksCompletion = _tasksCompletion
            self?.tableView.reloadData()
        }
        tableView.tableFooterView = UIView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.ref.removeAllObservers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else { return }
        ref = Database.database().reference(withPath: "users").child(String(currentUser.uid)).child("tasks")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasksCompletion.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        cell.labl.text = "\(indexPath.row + 1). \(tasks[indexPath.row])"
        cell.imageTask.image = UIImage(named: tasks[indexPath.row])
        
        let labelText: NSMutableAttributedString =  NSMutableAttributedString(string: "\(indexPath.row + 1). \(tasks[indexPath.row])")
        cell.labl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.accessoryType = tasksCompletion[indexPath.row].completed ? .checkmark : .none
        if (tasksCompletion[indexPath.row].completed) {
            labelText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, labelText.length))
            cell.labl.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        cell.labl.attributedText = labelText;
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tasksCompletion[indexPath.row].ref?.updateChildValues(["completed": !tasksCompletion[indexPath.row].completed])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
}
