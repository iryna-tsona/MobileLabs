//
//  RegistrationViewController.swift
//  HealthyLifestyle
//
//  Created by Ірина Цьона on 3/26/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    var ref: DatabaseReference!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.confirmPasswordTextField.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
    }
    //function for displaying alert
    func displayAlert(withText text: String, completion: ((UIAlertAction) -> ())?) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: completion)
        
        alertController.addAction(ok)
        present(alertController, animated: true)
    }


    @IBAction func registerButton(_ sender: UIButton) {
        //check if emails is not empty and if password and confirm passwords text fields is equal
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text, email != "", password != "", password == confirmPassword else {
            displayAlert(withText: "Incorrect input", completion: nil)
            return
        }
        //creating new user
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard error == nil, let user = authResult?.user else {
                self?.displayAlert(withText: "Creating user error: \(error!.localizedDescription)", completion: nil)
                return
            }
            let userRef = self?.ref.child(user.uid).child("userData")
            userRef?.setValue(["e-mail": user.email])
            let userTasksRef = self?.ref.child(user.uid).child("tasks")
            for order in 0...4 {
                let taskRef = userTasksRef?.child("task\(order)")
                taskRef?.setValue(["completed": false])
            }
            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                guard error == nil else {
                    self?.displayAlert(withText: "Sending verification email error: \(error!.localizedDescription)", completion: nil)
                    return
                }
            })
            do {
                try Auth.auth().signOut()
            } catch {
                print("sign out error: \(error.localizedDescription)")
            }
            self?.displayAlert(withText: "Verify your email and sign in", completion: { (alertAction) in
                self?.performSegue(withIdentifier: "login", sender: nil)
            })
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
