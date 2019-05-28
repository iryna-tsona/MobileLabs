//
//  MealsTableViewCell.swift
//  HealthyLifestyle
//
//  Created by Ірина Цьона on 3/25/19.
//  Copyright © 2019 Ірина Цьона. All rights reserved.
//

import UIKit

class MealsTableViewCell: UITableViewCell {

    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var carbohydratesLabel: UILabel!
    @IBOutlet weak var fatsLabel: UILabel!
    @IBOutlet weak var proteinsLabel: UILabel!
    @IBOutlet weak var mealsImage: UIImageView!
    @IBOutlet weak var mealsTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
