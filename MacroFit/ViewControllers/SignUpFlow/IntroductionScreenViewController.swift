//
//  IntroductionScreenViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 17/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit


class IntroductionScreenViewController: BaseViewController, UIScrollViewDelegate {

    @IBOutlet weak var featuresListScrollView: UIScrollView!
    @IBOutlet weak var featuresPageControl: UIPageControl!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    var features = ["Free workout plans from top fitness trainers", "Fitness challenges to keep you motivated", "Follow friends, share your progress, & see how others are keeping fit", "Premium firness courses from amazing instructors"]
    
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
                featureView.frame.size.height = featuresListScrollView.bounds.size.height
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
        if segue.destination is LoginViewController {
            let vc = segue.destination as! LoginViewController
            vc.showNavbar = true
        }
    }
    
    func signUpCompleted() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasicInfoViewController") as? BasicInfoViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
