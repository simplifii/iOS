//
//  IntroductionScreenViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 17/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class IntroductionScreenViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var featuresListScrollView: UIScrollView!
    @IBOutlet weak var featuresPageControl: UIPageControl!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var features = ["Custom meal plans & workouts for your specific goals", "Macros that make sense. Nutrition for your lifestyle.", "Fitness challenges and easy health eating."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFeatures()
        
        featuresListScrollView.isPagingEnabled = true
        featuresListScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(features.count), height: 75)
        featuresListScrollView.showsHorizontalScrollIndicator = false
        self.featuresListScrollView.delegate = self
        self.featuresPageControl.currentPage = 0
    }
    
    
    func loadFeatures() {
        for(index, feature) in features.enumerated() {
            if let featureView = Bundle.main.loadNibNamed("FeatureView", owner: self, options: nil)?.first as? FeatureView {
                featureView.featureLabel.text = feature
                
                featuresListScrollView.addSubview(featureView)
                
                featureView.frame.size.width = self.view.bounds.size.width
                featureView.frame.origin.x = CGFloat(index) *  self.view.bounds.size.width
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        featuresPageControl.currentPage = Int(page)
        backgroundImage.image = UIImage(named: "intro_screen_background\(Int(page) + 1)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginViewControllerSegue"{
            let vc = segue.destination as! LoginViewController
            vc.showNavbar = true
        }
    }
}
