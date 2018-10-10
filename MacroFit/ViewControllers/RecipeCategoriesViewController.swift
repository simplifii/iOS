//
//  RecipeCategoriesViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 10/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class RecipeCategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upgradeButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeSearchTextField()

        tableView.dataSource = self
        tableView.delegate = self
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCategoryTableViewCell") as! RecipeCategoryTableViewCell
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitRecipeTableViewCell") as! SubmitRecipeTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 4 {
            return 112
        }
        
        return 150
    }
    
    
    @IBAction func upgrade(_ sender: UIButton) {
    }
}
