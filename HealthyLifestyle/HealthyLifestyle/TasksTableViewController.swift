//
//  TasksTableViewController.swift
//  HealthyLifestyle
//
//  Created by Ірина Цьона on 3/23/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController {
    
    let tasksArray = ["Присідання", "Прес", "Стрибки", "Біг"]
    var complete: [Task] = []
    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int?
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        
        return components.day
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            complete = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        if complete.isEmpty {
            for _ in 0..<tasksArray.count {
                let appDelegate =  UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
                let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
                taskObject.isComplete = true
                
                do {
                    try context.save()
                    complete.append(taskObject)
                    print("Saved")
                } catch {
                    print(error.localizedDescription)
                }
                
            }
            
        } else {
            if daysBetweenDates(startDate: complete[0].lastSeen!, endDate: Date())! > 0 {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                for index in 0..<tasksArray.count {
                    do {
                        complete[index].isComplete = true
                        complete[0].lastSeen = Date()
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }

        do {
            complete[0].lastSeen = Date()
            
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasksArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        
        let labelText: NSMutableAttributedString =  NSMutableAttributedString(string: "\(indexPath.row + 1). \(tasksArray[indexPath.row])")
        cell.labl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.accessoryType = complete[indexPath.row].isComplete ? .none : .checkmark
        if (!complete[indexPath.row].isComplete) {
            labelText.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, labelText.length))
            cell.labl.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        cell.labl.attributedText = labelText;
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        saveTask(indexPath: indexPath)
        tableView.reloadData()
    }
    
    func saveTask(indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            complete[indexPath.row].isComplete = !complete[indexPath.row].isComplete
            
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
