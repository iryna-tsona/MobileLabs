//
//  TaskTableViewCell.swift
//  Lab2ios
//
//  Created by Богдан Дацьків on 3/23/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var labl: UILabel!
    
    //var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
