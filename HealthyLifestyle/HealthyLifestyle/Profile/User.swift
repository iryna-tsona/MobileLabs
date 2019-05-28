//
//  User.swift
//  HealthyLifestyle
//
//  Created by Bohdan Datskiv on 5/25/19.
//  Copyright © 2019 Дацьків Богдан. All rights reserved.
//

import Foundation
import Firebase

struct AppUser {
    let name: String?
    let surname: String?
    let ref: DatabaseReference?
    var email: String
    var image: UIImage?
    var age: String?
    var weight: String?
    var height: String?
    
    init(surname: String, name: String, email: String, image: UIImage, age: String, weight: String, height: String) {
        self.name = name
        self.surname = surname
        self.email = email
        self.image = image
        self.age = age
        self.weight = weight
        self.height = height
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as? String ?? "name"
        surname = snapshotValue["surname"] as? String ?? "surname"
        email = snapshotValue["e-mail"] as! String
        age = snapshotValue["age"] as? String ?? "-"
        weight = snapshotValue["weight"] as? String ?? "-"
        height = snapshotValue["height"] as? String ?? "-"
        ref = snapshot.ref
        guard let imageData = snapshotValue["profileImage"] as? String else { return }
        image = imageData.toImage()
    }
    
    func convertToDictionary() -> Any {
        return ["surname": surname, "name": name, "e-mail": email, "age": age, "weight": weight, "height": height, "profileImage": image?.toString()]
    }
}

