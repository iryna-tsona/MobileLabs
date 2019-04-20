//
//  ViewController.swift
//  HealthyLifestyle
//
//  Created by Ірина Цьона on 3/19/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //make fields empty
        emailTextField.text = ""
        passwordTextField.text = ""
        //add listener
        Auth.auth().addStateDidChangeListener { (auth, user) in
            //check if user already sign in?
            if user != nil {
                self.performSegue(withIdentifier: "signIn", sender: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //function for display different alerts
    func displayAlert(withText text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
    //method for login button
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // check if email and password texts fields are not empty
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayAlert(withText: "Fill the gaps")
            return
        }
        //sign in method
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            guard error == nil else {
                self.displayAlert(withText: "Sign in error")
                print("Sign in error: \(error!.localizedDescription)")
                return
            }
            guard let user = authResult?.user else {
                self.displayAlert(withText: "User error")
                return
            }
            //checking is email verified?
            if user.isEmailVerified {
                self.performSegue(withIdentifier: "signIn", sender: nil)
            } else  {
                self.displayAlert(withText: "email is not verified")
            }
        }
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "register", sender: nil)
    }
    
    //method for keyboard disappearing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func unwindSegue(seque: UIStoryboardSegue){
        
    }
}

