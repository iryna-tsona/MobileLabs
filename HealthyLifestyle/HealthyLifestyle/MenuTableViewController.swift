//
//  MenuTableViewController.swift
//  HealthyLifestyle
//
//  Created by Ірина Цьона on 3/19/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        buttons.forEach { (button) in
            button.layer.cornerRadius = 5
        }
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)

    }
    
    @IBAction func tasksButton(_ sender: UIButton) {
        performSegue(withIdentifier: "tasks", sender: nil)
    }
    @IBAction func mealsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "meals", sender: nil)
    }
    @IBAction func profileButton(_ sender: UIButton) {
        performSegue(withIdentifier: "profile", sender: nil)
    }
}
