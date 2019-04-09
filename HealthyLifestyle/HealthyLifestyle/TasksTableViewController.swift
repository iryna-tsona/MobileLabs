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
    
    var checkedArray = Array(repeating: false, count: 20)
    let tasksArray = ["Присідання", "Прес", "Стрибки", "Біг"]
    var complete: [Task] = []
    /*
     записати дату змінення в кор дату, потім рахувати різницю і відповідно до того міняти значення бул
     
     */
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
                //                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //                let context = appDelegate.persistentContainer.viewContext
                //
                //                let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
                //
                //                do {
                //                    complete = try context.fetch(fetchRequest)
                //                } catch {
                //                    print(error.localizedDescription)
                //                }
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                //let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
                for index in 0..<tasksArray.count {
                    do {
                        //complete = try context.fetch(fetchRequest)
                        complete[index].isComplete = true
                        complete[0].lastSeen = Date()
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    




override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    //        checkedArray[indexPath.row] = !checkedArray[indexPath.row]
    // complete[0].lastSeen = Date()
    saveTask(indexPath: indexPath)
    //complete[indexPath.row].isCompleted = !complete[indexPath.row].isCompleted
    tableView.reloadData()
}

func saveTask(indexPath: IndexPath) {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    //let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
    
    do {
        //complete = try context.fetch(fetchRequest)
        complete[indexPath.row].isComplete = !complete[indexPath.row].isComplete
        complete[0].lastSeen = Date()
        //  print(complete[0].lastSeen)
        try context.save()
        // print(complete[0].isComplete)
    } catch {
        print(error.localizedDescription)
    }
}

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

}
