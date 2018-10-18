//
//  RecipeTableViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 17/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecipeTableViewController: UITableViewController {

    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var progressBarContainerView: UIView!
    @IBOutlet weak var progressBarView: UIProgressView!
    @IBOutlet weak var macroAccuracyPercentageLabel: UILabel!
    
    @IBOutlet weak var mealsPerDayTextLabel: UILabel!
    
    
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var instructionsPhotoImaageView: UIImageView!
    
    var recipeData:JSON = [:]
    var mealsPerDay:Int = 0
    var macrosAccuracyPercentage:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clear

        tableView.layer.cornerRadius = 9.0
        
        setupView()
    }
    
    func setupView() {
        ingredientsTextView.text = recipeData["ingredients"].stringValue
        
        caloriesLabel.text = recipeData["calorie"].stringValue
        carbsLabel.text = "\(recipeData["carbs"].stringValue)g"
        proteinLabel.text = "\(recipeData["protein"].stringValue)g"
        fatLabel.text = "\(recipeData["fat"].stringValue)g"
        
        mealsPerDayTextLabel.text = "*Based off your meal size settings of \(mealsPerDay) meals / day"
        
        instructionsTextView.text = recipeData["recipe_instructions"].stringValue

        
        if !recipeData["instructions_photo"].stringValue.isEmpty {
            let url = URL(string: recipeData["instructions_photo"].stringValue)!
            instructionsPhotoImaageView.af_setImage(withURL: url)
        } else if !recipeData["photo"].stringValue.isEmpty {
            let url = URL(string: recipeData["photo"].stringValue)!
            instructionsPhotoImaageView.af_setImage(withURL: url)
        }
        
        macroAccuracyPercentageLabel.text = "\(macrosAccuracyPercentage)%"
        
        customProgressBar()
    }
    
    func customProgressBar() {
        progressBarView.transform = progressBarView.transform.scaledBy(x: 1, y: 8)
        progressBarView.progress = Float(macrosAccuracyPercentage)/100.0
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 230 + ingredientsTextView.contentSize.height
        } else if indexPath.row == 2 {
            return 300 + instructionsTextView.contentSize.height
        }
        
        return 44
    }

}
