//
//  RecommendedDailyMacrosViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 19/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecommendedDailyMacrosViewController: OnboardUserViewController {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    
    @IBOutlet weak var mealsSelectionView: RoundedCornerBoxView!

    @IBOutlet weak var mealCountTitleLabel: UILabel!
    @IBOutlet weak var caloriesCountLabel: UILabel!
    @IBOutlet weak var carbsContentLabel: UILabel!
    @IBOutlet weak var proteinContentLabel: UILabel!
    @IBOutlet weak var fatContentLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var userProfile:JSON = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecommendedDailyMacros()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: 450);
    }
    
    
    // Setup and customize View
    func setupView() {
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: true)
         self.addProgressBarInView(progressBarView: progressBarView, percent: 60, description: "Customizing your Macros")
        
        setMealsCountTitle(mealCount: 3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func getRecommendedDailyMacros() {
        APIService.getRecommendedDailyMacros(completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.setMealsCountTitle(mealCount: data[0]["meals_per_day"].intValue)
                self.caloriesCountLabel.text = data[0]["calories"].stringValue
                self.carbsContentLabel.text = data[0]["carbs"].stringValue
                self.proteinContentLabel.text = data[0]["protein"].stringValue
                self.fatContentLabel.text = data[0]["fat"].stringValue
            }
        })
    }

    @IBAction func saveToPhotos(_ sender: UIButton) {
    }
    
    func setMealsCountTitle(mealCount: Int) {
         mealCountTitleLabel.text = "Eat \(mealCount) meals a day to"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DietaryPreferencesViewController {
            let vc = segue.destination as! DietaryPreferencesViewController
            vc.userProfile = userProfile
        }
    }
}
