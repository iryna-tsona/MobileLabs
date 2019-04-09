//
//  ViewController.swift
//  HealthyLifestyle
//
//  Created by Ірина Цьона on 3/19/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func login(_ sender: UIButton) {
        performSegue(withIdentifier: "login", sender: nil)
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "register", sender: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func unwindSegue(seque: UIStoryboardSegue){
        
    }
}

