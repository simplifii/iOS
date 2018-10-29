//
//  HomeViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 23/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: BaseViewController, ThankYouPopupDelegate {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var fatWeightLabel: UILabel!
    @IBOutlet weak var fatWeightUnitLabel: UILabel!
    
    @IBOutlet weak var bodyFatNotEnteredButton: UIButton!
    
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var ratingContainerView: UIView!
    
    @IBOutlet weak var mealsScrollView: UIScrollView!
    var meals:JSON = []
    
    var userProfile:JSON = [:]
    var feedbackCardUniqueCode:String = ""
    
    var ratingView:RatingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMealsInView()
//        addMenuNavbarInView(navbarView: navbarView)
        
        addRatingView()
        
        setAppFeedback()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUserMacrosData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundScrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: 380)        
    }
    
    func addRatingView() {
        ratingView = Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)?.first as? RatingView
        ratingView!.frame.size = ratingContainerView.bounds.size
        ratingContainerView.addSubview(ratingView!)
        
        ratingView!.starOneButton.addTarget(self, action: #selector(self.showRatingInRatingView(_:)), for: UIControlEvents.touchUpInside)
        ratingView!.startTwoButton.addTarget(self, action: #selector(self.showRatingInRatingView(_:)), for: UIControlEvents.touchUpInside)
        ratingView!.starThreeButton.addTarget(self, action: #selector(self.showRatingInRatingView(_:)), for: UIControlEvents.touchUpInside)
        ratingView!.starFourButton.addTarget(self, action: #selector(self.showRatingInRatingView(_:)), for: UIControlEvents.touchUpInside)
        ratingView!.starFiveButton.addTarget(self, action: #selector(self.showRatingInRatingView(_:)), for: UIControlEvents.touchUpInside)
        
    }
    
    func addMealsInMealsScrollView() {
        let mealsCount = CGFloat(meals.count)
        let height = mealsScrollView.bounds.size.height
        
        mealsScrollView.contentSize = CGSize(width:(mealsCount * height) + (mealsCount * 10.0), height: height);
        
        for(key, meal) in meals {
            if let mealInfoView = Bundle.main.loadNibNamed("MealInfoBoxView", owner: self, options: nil)?.first as? MealInfoBoxView {
                let index = CGFloat(Int(key)!)
                
                mealsScrollView.addSubview(mealInfoView)
                                
                mealInfoView.frame.size.height = mealsScrollView.bounds.size.height
                mealInfoView.frame.size.width = mealsScrollView.bounds.size.height
                
                mealInfoView.frame.origin.x = (index * mealsScrollView.bounds.size.height) + (index * 10)
                
                let url = URL(string: meal["photo"].stringValue)!
                mealInfoView.backgroundImageView.af_setImage(withURL: url)
                
                mealInfoView.mealTitleLabel.text =  meal["title"].stringValue
                mealInfoView.caloriesLabel.text =  meal["calorie"].stringValue
                mealInfoView.carbsLabel.text =  meal["carbs"].stringValue
                mealInfoView.proteinLabel.text =  meal["protein"].stringValue
                mealInfoView.fatLabel.text =  meal["fat"].stringValue
                mealInfoView.showMealButton.addTarget(self, action: #selector(self.showMealScreen(_:)), for: UIControlEvents.touchUpInside)
            }
        }
    }
    
    @objc func showMealScreen(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 1
    }
    
    @objc func showRatingInRatingView(_ sender: UIButton) {
        if feedbackCardUniqueCode.isEmpty {
            let rating = Int(sender.accessibilityHint!)!
            ratingView!.setRating(rating: rating)
            createAppFeedback(rating: rating)
        }
    }
    
    func showRatingAndTextModal() {
        let popOverVC = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "RatingAndTextFeedbackViewController") as? RatingAndTextFeedbackViewController
        popOverVC?.uniqueCode = feedbackCardUniqueCode
        popOverVC!.thankYouPopupDelegate = self
        
        self.addChildViewController(popOverVC!)
        popOverVC!.view.frame = self.view.frame
        self.view.addSubview(popOverVC!.view)
        popOverVC!.didMove(toParentViewController: self)
    }
    
    func showRatingModal() {
        let popOverVC = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "RatingViewController") as? RatingViewController
        popOverVC!.thankYouPopupDelegate = self
        self.addChildViewController(popOverVC!)
        popOverVC!.view.frame = self.view.frame
        self.view.addSubview(popOverVC!.view)
        popOverVC!.didMove(toParentViewController: self)
    }
    
    
    
    func setupSegmentedControlView() {
        UISegmentedControl.appearance().setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "Montserrat", size: 10)!,
            ], for: .normal)
        segmentedControl.layer.borderColor = Constants.schemeColor.cgColor
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.cornerRadius = 3.0
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.frame = CGRect(x: segmentedControl.frame.minX, y: segmentedControl.frame.minY, width: segmentedControl.frame.width, height: 20)
    }
    
    
    func setUserMacrosData() {
        APIService.getUserProfile(completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.userProfile = data[0]
                self.setUpMacrosData()
            }
        })
    }
    
    func setUpMacrosData() {
        setPerMealData()
        
        weightLabel.text = userProfile["weight"].stringValue
        
        let bodyFat = userProfile["cdata"]["body_fat"].stringValue
        if bodyFat.isEmpty {
            bodyFatNotEnteredButton.isHidden = false
            
            fatWeightLabel.isHidden = true
            fatWeightUnitLabel.isHidden = true
        } else {
            bodyFatNotEnteredButton.isHidden = true
            
            fatWeightLabel.isHidden = false
            fatWeightUnitLabel.isHidden = false
            
            fatWeightLabel.text = bodyFat
        }
    }
    
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        if userProfile.count > 0 {
            if segmentedControl.selectedSegmentIndex == 0 {
                setPerMealData()
            } else {
                caloriesLabel.text = userProfile["cdata"]["calories_per_day"].stringValue
                carbsLabel.text = "\(userProfile["cdata"]["carbs_per_day"].intValue)g"
                proteinLabel.text = "\(userProfile["cdata"]["protein_per_day"].intValue)g"
                fatLabel.text = "\(userProfile["cdata"]["fat_per_day"].intValue)g"
            }
        }
    }
    
    func setPerMealData() {
        caloriesLabel.text = userProfile["calories"].stringValue
        carbsLabel.text = "\(userProfile["carbs"].intValue)g"
        proteinLabel.text = "\(userProfile["protein"].intValue)g"
        fatLabel.text = "\(userProfile["fat"].intValue)g"
    }
    
    
    func createAppFeedback(rating: Int) {
        APIService.createFeedback(rating: rating, completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.feedbackCardUniqueCode = data[0]["unique_code"].stringValue
                
                if rating < 5 {
                    self.showRatingAndTextModal()
                } else {
                    self.showRatingModal()
                }
            }
        })
    }
    
    func setAppFeedback() {
        APIService.getFeedback(completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                let rating = data[0]["rating"].intValue
                self.ratingView!.setRating(rating: rating)
                self.feedbackCardUniqueCode = data[0]["unique_code"].stringValue
            }
        })
    }
    
    func showThankPopup() {
        let popOverVC = UIStoryboard(name: "MacroFit", bundle: nil).instantiateViewController(withIdentifier: "ThankYouPopupViewController") as? ThankYouPopupViewController
        
        self.addChildViewController(popOverVC!)
        popOverVC!.view.frame = self.view.frame
        self.view.addSubview(popOverVC!.view)
        popOverVC!.didMove(toParentViewController: self)
    }
    
    
    func setMealsInView() {
        APIService.getMealsMenu(completion: {success,msg,data in
            if success == true {
                self.meals = data
                self.addMealsInMealsScrollView()
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is WeightAndBodyFatViewController {
            let vc = segue.destination as? WeightAndBodyFatViewController
            vc?.weight = weightLabel.text
        }
    }
    
}
