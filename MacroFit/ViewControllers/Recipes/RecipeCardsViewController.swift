//
//  RecipeCardsViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 11/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecipeCardsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, RecipeCardTableViewCellDelegate {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var recipeTagLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var recipeTag:String = ""
    var showFavourites:Bool = false
    
    var recipes:[JSON] = []
    
    var userDietType:String = ""
    var mealsPerDay:Int = 0
    var calories: Int = 0
    var carbs:Int = 0
    var protein:Int = 0
    var fat:Int = 0
    
    
    var markedFavouriteRecipes:[String] = []
    
    var selectedRecipe = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserDietDetails()
        
        if showFavourites == true {
            recipeTagLabel.text = "My favourites"
        } else {
            recipeTagLabel.text = recipeTag
        }

        self.addBackNavbarInView(navbarView: navbarView, settings_visible: true)

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if mealsPerDay > 0 {
            self.setRecipes(recipeTag: self.recipeTag)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCardTableViewCell") as! RecipeCardTableViewCell
        cell.isFavourite = false
        
        cell.recipeNameLabel.text = recipes[indexPath.row]["title"].stringValue
        
        cell.recipeId = recipes[indexPath.row]["unique_code"].stringValue
        cell.recipeCardTableViewCellDelegate = self
        
        if !recipes[indexPath.row]["photo"].stringValue.isEmpty {
            let url = URL(string: recipes[indexPath.row]["photo"].stringValue)!
            cell.recipeImageView.af_setImage(withURL: url)
        }
        
        cell.isFavourite = isFavourite(index: indexPath.row)
        
        cell.setFavouriteButtonImage()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = indexPath.row
        gotoRecipeScreen()
    }
    
    func isFavourite(index: Int)->Bool {
        if showFavourites == true {
            return true
        }
        
        if markedFavouriteRecipes.contains(recipes[index]["unique_code"].stringValue) {
            return true
        }
        
        return false
    }

    
    func setRecipes(recipeTag: String) {
        self.recipes = []
        self.markedFavouriteRecipes = []
        
        APIService.getUserRecipes(recipeTag: recipeTag, completion: {success,msg,data in
            if success == true {
                if data != JSON.null {
                    for (_,recipe) in data {
                        if recipe["is_favourite"].boolValue {
                            let uniqueCode = recipe["unique_code"].stringValue
                            self.markedFavouriteRecipes.append(uniqueCode)
                        }
                        
                        if self.showFavourites == true {
                            if recipe["is_favourite"].boolValue {
                                self.recipes.append(recipe)
                            }
                        }
                    }
                    
                    if self.showFavourites == false {
                        self.recipes = data.arrayValue
                        //self.setRecipesData(recipes: data)
                    }
                    
                    self.tableView.reloadData()
                }
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    
    func setRecipesData(recipes:JSON) {
        if userDietType.isEmpty {
            self.recipes = recipes.arrayValue
        } else {
            var data:[JSON] = []
            for (_,recipe) in recipes {
                let dietTypesString = recipe["diet_type"].stringValue
                
                if dietTypesString.isEmpty {
                    data.append(recipe)
                } else {
                    let dietTypes = dietTypesString.components(separatedBy: ",")
                    if dietTypes.contains(userDietType) {
                        if isRecipeRecommendedForUser(
                            recipeCalories: recipe["calorie"].intValue,
                            recipeProtein: recipe["protein"].intValue,
                            recipeCarbs: recipe["carbs"].intValue,
                            recipeFat: recipe["fat"].intValue) {
                            
                            data.append(recipe)
                        }
                    }
                }
            }

            self.recipes = data
        }
    }
    
    func isRecipeRecommendedForUser(recipeCalories:Int, recipeProtein:Int, recipeCarbs:Int, recipeFat:Int)->Bool {
        if valuesLiesInPercentangeRange(originalValue:recipeCalories, newValue:calories, percent:20) == false {
            return false
        }
        if valuesLiesInPercentangeRange(originalValue:recipeProtein, newValue:protein, percent:15) == false {
            return false
        }
        if valuesLiesInPercentangeRange(originalValue:recipeCarbs, newValue:carbs, percent:15) == false {
            return false
        }
        if valuesLiesInPercentangeRange(originalValue:recipeFat, newValue:fat, percent:15) == false {
            return false
        }
        
        return true
    }
    
    func valuesLiesInPercentangeRange(originalValue:Int, newValue:Int, percent:Int)->Bool {
        var diff = 0
        if originalValue > 0 {
            diff = ((originalValue - newValue) / originalValue) * 100
        } else if newValue > 0 {
            diff = ((newValue - originalValue) / newValue) * 100
        }
        
        if Int(diff).magnitude <= percent {
            return true
        }
        return false
    }
    
    func setUserDietDetails() {
        APIService.getUserProfile(completion: {success,msg,data in
            if success == true {
                if data != JSON.null {
                    self.mealsPerDay = data[0]["meals_per_day"].intValue
                    self.calories = data[0]["calories"].intValue
                    self.carbs = data[0]["carbs"].intValue
                    self.protein = data[0]["protein"].intValue
                    self.fat = data[0]["fat"].intValue
                    self.userDietType = data[0]["cdata"]["dietary_preference"].stringValue
                    
                    self.setRecipes(recipeTag: self.recipeTag)
                }
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    func markRecipeFavourite(cell: RecipeCardTableViewCell) {
        if cell.isFavourite == false {
            if !markedFavouriteRecipes.contains(cell.recipeId) {
                markedFavouriteRecipes.append(cell.recipeId)
                cell.markFavourite()
                callMarkRecipeFavouriteAPI(cell: cell)
            }
        }
    }
    
    func callMarkRecipeFavouriteAPI(cell: RecipeCardTableViewCell) {
        APIService.markRecipeAsFavourite(cardUniqueCode: cell.recipeId, completion: {success,msg in
            if success != true {
                cell.isFavourite = false
                cell.setFavouriteButtonImage()
                if let index = self.markedFavouriteRecipes.index(of: cell.recipeId) {
                    self.markedFavouriteRecipes.remove(at: index)
                }
                
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    func gotoRecipeScreen() {
        let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "RecipeViewController") as? RecipeViewController
        vc?.recipeData = recipes[selectedRecipe]
        vc?.isFavourite = isFavourite(index: selectedRecipe)
        vc?.mealsPerDay = mealsPerDay
        
        vc?.userDefinedCalories = calories
        vc?.userDefinedProtein = protein
        vc?.userDefinedCarbs = carbs
        vc?.userDefinedFat = fat
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
