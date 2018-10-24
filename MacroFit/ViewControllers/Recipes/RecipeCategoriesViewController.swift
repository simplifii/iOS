//
//  RecipeCategoriesViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 10/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecipeCategoriesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upgradeButton: UIButton!
    
    var recipeTags:[[String:String]] = []
    var filteredRecipeTags:[[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRecipeTags()
        
        customizeSearchTextField()

        tableView.dataSource = self
        tableView.delegate = self
        
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)

    }
    
    func customizeSearchTextField() {
        // Shadow
        searchTextField.layer.shadowOpacity = 0.2
        searchTextField.layer.shadowColor = UIColor.lightGray.cgColor
        searchTextField.layer.shadowRadius = 5.0
        searchTextField.layer.shadowOffset = CGSize.zero
        searchTextField.layer.shadowPath =
            UIBezierPath(roundedRect: searchTextField.bounds,
                         cornerRadius: searchTextField.layer.cornerRadius).cgPath
        
        searchTextField.frame.insetBy(dx: 10.0, dy: 0)
        
      
        searchTextField.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 35, height: 15))
        let image = UIImage(named: "search.png")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        searchTextField.rightView = imageView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRecipeTags.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCategoryTableViewCell") as! RecipeCategoryTableViewCell
            cell.categoryNameLabel.text = "My Favourites"
            cell.iconImageView.image = UIImage(named: "heart_white.png")
            cell.backgroundImageView.image = UIImage(named: "favourites.png")
            
            return cell
        } else if indexPath.row == filteredRecipeTags.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitRecipeTableViewCell") as! SubmitRecipeTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCategoryTableViewCell") as! RecipeCategoryTableViewCell
        cell.categoryNameLabel.text = filteredRecipeTags[indexPath.row - 1]["label"]
        
        if !filteredRecipeTags[indexPath.row - 1]["icon"]!.isEmpty {
            let url = URL(string: filteredRecipeTags[indexPath.row - 1]["icon"]!)!
            cell.iconImageView.af_setImage(withURL: url)
        } else {
            cell.backgroundImageView.image = UIImage(named: "favourites.png")
        }
        
        if !filteredRecipeTags[indexPath.row - 1]["image"]!.isEmpty {
            let url = URL(string: filteredRecipeTags[indexPath.row - 1]["image"]!)!
            cell.backgroundImageView.af_setImage(withURL: url)
        } else {
            cell.backgroundImageView.image = UIImage(named: "favourites.png")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < filteredRecipeTags.count + 1 {
            return 112
        }
        
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0)  {
            let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "RecipeCardsViewController") as? RecipeCardsViewController
            vc?.showFavourites = true
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        } else if (indexPath.row < filteredRecipeTags.count + 1) {
            let vc = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "RecipeCardsViewController") as? RecipeCardsViewController
            vc?.recipeTag = filteredRecipeTags[indexPath.row - 1]["label"]!
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func upgrade(_ sender: UIButton) {
    }
    
    func getRecipeTags() {
        APIService.getRecipeTags(completion: {success,msg,data in
            if success == true {
                for (_,recipe) in data {
                    self.recipeTags.append([
                        "label": recipe["label"].stringValue,
                        "image": recipe["image"].stringValue,
                        "icon": recipe["cdata"]["icon"].stringValue
                    ])
                }
                self.filteredRecipeTags = self.recipeTags
                self.tableView.reloadData()
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (searchTextField.text?.count)! != 0 {
            self.filteredRecipeTags.removeAll()
            for recipe in recipeTags {
                let range = recipe["label"]!.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    self.filteredRecipeTags.append(recipe)
                }
            }
        } else {
            self.filteredRecipeTags = self.recipeTags
        }
        tableView.reloadData()
    }
}
