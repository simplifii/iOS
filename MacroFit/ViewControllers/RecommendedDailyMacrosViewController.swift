//
//  RecommendedDailyMacrosViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 19/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class RecommendedDailyMacrosViewController: OnboardUserViewController {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    
    @IBOutlet weak var mealsSelectionView: RoundedCornerBoxView!

    @IBOutlet weak var mealCountTitleLabel: UILabel!
    @IBOutlet weak var caloriesCountLabel: UILabel!
    @IBOutlet weak var carbsContentLabel: UILabel!
    @IBOutlet weak var proteinContentLabel: UILabel!
    @IBOutlet weak var fatContentLabel: UILabel!
    
    var mealsCount = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addDataInView()
    }
    
    func addDataInView() {
        mealCountTitleLabel.text = "Eat \(mealsCount) meals a day to"
    }
    
    // Setup and customize View
    func setupView() {
        self.addBackNavbarInView(navbarView: navbarView)
        self.addProgressBarInView(progressBarView: progressBarView, percent: 60, description: "Customizing your Macros")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

    @IBAction func saveToPhotos(_ sender: UIButton) {
    }
    
}
