//
//  MealsTableViewController.swift
//  HealthyLifestyle
//
//  Created by Ірина Цьона on 3/25/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit

class MealsTableViewController: UITableViewController {
    
    let meals = ["chiken", "bread", "eggs", "broth", "zander"]
    let calories = ["108", "190", "140", "9", "44"]
    let carbohydrates = ["0.9", "39.3", "0.5", "0.41", "-" ]
    let fats = ["4.1", "0.6", "10.1", "0.32", "0.2" ]
    let proteins = ["16.0", "5.5", "10.7", "1.21", "10.4"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealsTableViewCell
        cell.mealsTitle.text = meals[indexPath.row]
        cell.proteinsLabel.text = proteins[indexPath.row]
        cell.fatsLabel.text = fats[indexPath.row]
        cell.carbohydratesLabel.text = carbohydrates[indexPath.row]
        cell.caloriesLabel.text = calories[indexPath.row]
        cell.mealsImage.image = UIImage(named: meals[indexPath.row])
        
        
        return cell
    }
}
