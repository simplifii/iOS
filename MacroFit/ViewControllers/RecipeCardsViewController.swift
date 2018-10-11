//
//  RecipeCardsViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 11/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecipeCardsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var recipeTagLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var recipeTag:String = ""
    var showFavourites:Bool = false
    
    var recipes:JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if showFavourites == true {
            setFavouriteRecipes()
            recipeTagLabel.text = "My favourites"
        } else {
            setRecipes(recipeTag: recipeTag)
        }

        self.addBackNavbarInView(navbarView: navbarView, settings_visible: true)

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCardTableViewCell") as! RecipeCardTableViewCell
        
        cell.recipeNameLabel.text = recipes[indexPath.row]["title"].stringValue
        
        if !recipes[indexPath.row]["photo"].stringValue.isEmpty {
            let url = URL(string: recipes[indexPath.row]["photo"].stringValue)!
            cell.recipeImageView.af_setImage(withURL: url)
        }
        
        if showFavourites == true {
            cell.favouriteImageView.image = UIImage(named: "heart_full.png")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func setFavouriteRecipes() {
        APIService.getUserFavouriteRecipes(completion: {success,msg,data in
            if success == true {
                if data != JSON.null {
                    self.recipes = data
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func setRecipes(recipeTag: String) {
        APIService.getRecipesList(recipeTag: recipeTag, completion: {success,msg,data in
            if success == true {
                if data != JSON.null {
                    self.recipes = data
                    self.tableView.reloadData()
                }
            }
        })
    }

}
