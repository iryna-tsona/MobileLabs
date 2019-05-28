//
//  Tasks.swift
//  HealthyLifestyle
//
//  Created by Bohdan Datskiv on 5/25/19.
//  Copyright © 2019 Дацьків Богдан. All rights reserved.
//

import Foundation
import Firebase

struct FireTask {
    var completed: Bool
    let ref: DatabaseReference?
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    init(completed: Bool) {
        self.completed = completed
        self.ref = nil
    }
    
    func convertToDictionary() -> Any {
        return ["completed": completed]
    }

}
