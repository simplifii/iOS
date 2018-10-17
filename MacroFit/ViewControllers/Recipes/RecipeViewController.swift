//
//  RecipeViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 17/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecipeViewController: BaseViewController {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipePhotoImageView: UIImageView!
    @IBOutlet weak var favouriteIconImageView: UIImageView!
    
    var recipeData:JSON = [:]
    var isFavourite:Bool = false
    var mealsPerDay:Int = 0
    
    var userDefinedCalories:Int = 0
    var userDefinedCarbs:Int = 0
    var userDefinedProtein:Int = 0
    var userDefinedFat:Int = 0
    
    var macrosAccuracyPercentage:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeNameLabel.text = recipeData["title"].stringValue
        
        if !recipeData["photo"].stringValue.isEmpty {
            let url = URL(string: recipeData["photo"].stringValue)!
            recipePhotoImageView.af_setImage(withURL: url)
        }
        
        if isFavourite == true {
            favouriteIconImageView.image = UIImage(named: "heart_full_white.png")
        }
        
        macrosAccuracyPercentage = getMacroAccuracyPercentage()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RecipeTableViewController
        {
            let vc = segue.destination as? RecipeTableViewController
            vc?.recipeData = recipeData
            vc?.mealsPerDay = mealsPerDay
            vc?.macrosAccuracyPercentage = macrosAccuracyPercentage
        }
    }
    
    
    func getMacroAccuracyPercentage()->Int {
        let calories = recipeData["calorie"].intValue
        let protein = recipeData["protein"].intValue
        let carbs = recipeData["carbs"].intValue
        let fat = recipeData["fat"].intValue
        
        let caloriesChange = changeInPercentage(originalValue: userDefinedCalories, newValue: calories)
        let proteinChange = changeInPercentage(originalValue: userDefinedProtein, newValue: protein)
        let carbsChange = changeInPercentage(originalValue: userDefinedCarbs, newValue: carbs)
        let fatChange = changeInPercentage(originalValue: userDefinedFat, newValue: fat)
        
        let average = Int((caloriesChange + proteinChange + carbsChange + fatChange)/4)
        
        return ((average > 0) ? average : 0)
    }
    
    func changeInPercentage(originalValue:Int, newValue:Int)->Int {
        var diff = 0
        if originalValue > 0 {
            diff = ((originalValue - newValue) / originalValue) * 100
        } else if newValue > 0 {
            diff = ((newValue - originalValue) / newValue) * 100
        }
        
        return Int(diff)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.showPreviousScreen()
    }
    
}
