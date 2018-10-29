//
//  MealInfoBoxView.swift
//  MacroFit
//
//  Created by Chandresh Singh on 29/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class MealInfoBoxView: UIView {

    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var showMealButton: UIButton!
    
    
    override func awakeFromNib() {
        viewSetup()
    }
    
    func viewSetup() {
        self.layer.cornerRadius = 8.0
        backgroundImageView.layer.cornerRadius = 8.0
        backgroundImageView.clipsToBounds = true
        self.clipsToBounds = true
    }
    
    
}
