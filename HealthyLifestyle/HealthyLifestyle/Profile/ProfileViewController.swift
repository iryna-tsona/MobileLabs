//
//  ProfileViewController.swift
//  HealthyLifestyle
//
//  Created by Ірина Цьона on 3/25/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    var ref: DatabaseReference!
    var user: AppUser!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var scrollingView: UIScrollView!
    var editFields = false
    var tempImage = UIImage()
    var imageSeted = false
    
    override func viewWillAppear(_ animated: Bool) {
        self.ref.observe(.value, with: {[weak self] (snapshot) in
            let _user = AppUser(snapshot: snapshot)
            self?.user = _user
            self?.emailLabel.text = self?.user.email
            self?.nameLabel.text = self?.user.name
            self?.surnameLabel.text = self?.user.surname
            self?.ageLabel.text = self?.user.age
            self?.weightLabel.text = self?.user.weight
            self?.heightLabel.text = self?.user.height
            if self!.imageSeted {
                self?.profileImage.image = self?.user.image
            }
        })
    }
    override var shouldAutorotate: Bool {
        return  false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        guard let currentUser = Auth.auth().currentUser else { return }
        ref = Database.database().reference(withPath: "users").child(String(currentUser.uid)).child("userData")
        emailTextField.isHidden = true
        nameTextField.isHidden = true
        surnameTextField.isHidden = true
        uploadImageButton.isHidden = true
        ageTextField.isHidden = true
        weightTextField.isHidden = true
        heightTextField.isHidden = true
    }
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
       scrollingView.contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        scrollingView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
        
    }
    
    @objc func kbDidHide() {
        scrollingView.contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    @IBAction func logoutTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("sign out error: \(error.localizedDescription)")
        }
    }

    @IBAction func uploadImageTapped(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.allowsEditing = false
        let choseSourceAC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            image.sourceType = .camera
            self.present(image, animated: true)
        }
        let library = UIAlertAction(title: "Photo library", style: .default) { (action) in
            image.sourceType = .photoLibrary
            self.present(image, animated: true)
        }
        choseSourceAC.addAction(camera)
        choseSourceAC.addAction(library)
        self.present(choseSourceAC, animated: true)
    }
    @IBAction func editButtonTapped(_ sender: UIButton) {
        editFields ? done() : editing()
        editFields = !editFields
    }
    
    func editing() {
        editButton.setTitle("Done", for: .normal)
        emailTextField.isHidden = false
        nameTextField.isHidden = false
        surnameTextField.isHidden = false
        uploadImageButton.isHidden = false
        ageTextField.isHidden = false
        weightTextField.isHidden = false
        heightTextField.isHidden = false
        emailLabel.isHidden = true
        nameLabel.isHidden = true
        surnameLabel.isHidden = true
        ageLabel.isHidden = true
        weightLabel.isHidden = true
        heightLabel.isHidden = true
        emailTextField.text = emailLabel.text
        nameTextField.text = nameLabel.text
        surnameTextField.text = surnameLabel.text
        ageTextField.text = ageLabel.text
        weightTextField.text = weightLabel.text
        heightTextField.text = heightLabel.text
    }
    func done() {
        self.view.endEditing(true)
        editButton.setTitle("Edit", for: .normal)
        emailTextField.isHidden = true
        nameTextField.isHidden = true
        surnameTextField.isHidden = true
        uploadImageButton.isHidden = true
        ageTextField.isHidden = true
        weightTextField.isHidden = true
        heightTextField.isHidden = true
        emailLabel.isHidden = false
        nameLabel.isHidden = false
        surnameLabel.isHidden = false
        ageLabel.isHidden = false
        weightLabel.isHidden = false
        heightLabel.isHidden = false
        emailLabel.text = emailTextField.text
        nameLabel.text = nameTextField.text
        surnameLabel.text = surnameTextField.text
        ageLabel.text = ageTextField.text
        weightLabel.text = weightTextField.text
        heightLabel.text = heightTextField.text
        let user = AppUser(surname: surnameLabel.text!, name: nameLabel.text!, email: emailLabel.text!, image: tempImage, age: ageLabel.text!, weight: weightLabel.text!, height: heightLabel.text!)
        ref.setValue(user.convertToDictionary())
        //imageSeted = true
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}
extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}

extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

extension ProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {}
