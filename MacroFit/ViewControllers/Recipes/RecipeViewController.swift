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
    @IBOutlet weak var favouriteIconButton: UIButton!
    
    var recipeData:JSON = [:]
    var isFavourite:Bool = false
    var mealsPerDay:Int = 0
    
    var userDefinedCalories:Int = 0
    var userDefinedCarbs:Int = 0
    var userDefinedProtein:Int = 0
    var userDefinedFat:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeNameLabel.text = recipeData["title"].stringValue
        
        if !recipeData["photo"].stringValue.isEmpty {
            let url = URL(string: recipeData["photo"].stringValue)!
            recipePhotoImageView.af_setImage(withURL: url)
        }
        
        print(isFavourite)
        setFavouriteButtonIcon(isFav: isFavourite)
    }
    
    func setFavouriteButtonIcon(isFav: Bool) {
        if isFav == true {
            isFavourite = true
            favouriteIconButton.setImage(UIImage(named: "heart_full_white.png"), for: .normal)
        } else {
            isFavourite = false
            favouriteIconButton.setImage(UIImage(named: "heart_white.png"), for: .normal)
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RecipeTableViewController
        {
            let vc = segue.destination as? RecipeTableViewController
            vc?.recipeData = recipeData
            vc?.mealsPerDay = mealsPerDay
            vc?.macrosAccuracyPercentage = getMacroAccuracyPercentage()
        }
    }
    
    
    func getMacroAccuracyPercentage()->Int {
        let calories = recipeData["calorie"].doubleValue
        let protein = recipeData["protein"].doubleValue
        let carbs = recipeData["carbs"].doubleValue
        let fat = recipeData["fat"].doubleValue
        
        let caloriesChange = changeInPercentage(originalValue: Double(userDefinedCalories), newValue: calories)
        let proteinChange = changeInPercentage(originalValue: Double(userDefinedProtein), newValue: protein)
        let carbsChange = changeInPercentage(originalValue: Double(userDefinedCarbs), newValue: carbs)
        let fatChange = changeInPercentage(originalValue: Double(userDefinedFat), newValue: fat)
        
        let average = Int((caloriesChange + proteinChange + carbsChange + fatChange)/4)
        
        return average
    }
    
    func changeInPercentage(originalValue:Double, newValue:Double)->Int {
        var diff = 0.0
        if originalValue > newValue {
            diff = newValue / originalValue
        } else {
            diff = originalValue / newValue
        }
        
        return Int(diff*100)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.showPreviousScreen()
    }
    
    
    @IBAction func markFavourite(_ sender: UIButton) {
        let recipeUniqueCode = recipeData["unique_code"].stringValue
        
        if isFavourite == false {
            setFavouriteButtonIcon(isFav: true)
            
            APIService.markRecipeAsFavourite(cardUniqueCode: recipeUniqueCode, completion: {success,msg in
                if success != true {
                    self.setFavouriteButtonIcon(isFav: false)
                    
                    self.showAlertMessage(title: msg, message: nil)
                }
            })
        } else {
            setFavouriteButtonIcon(isFav: false)
            
            let recipeId = recipeData["id"].intValue
            
            APIService.unfavouriteRecipe(cardUniqueCode: recipeUniqueCode, recipeId: recipeId, completion: {success,msg in
                if success == false {
                    self.setFavouriteButtonIcon(isFav: true)
                    
                    self.showAlertMessage(title: msg, message: nil)
                }
            })
        }
    }
    
}
