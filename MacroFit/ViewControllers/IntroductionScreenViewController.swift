//
//  IntroductionScreenViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 17/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class IntroductionScreenViewController: BaseViewController, UIScrollViewDelegate {

    @IBOutlet weak var featuresListScrollView: UIScrollView!
    @IBOutlet weak var featuresPageControl: UIPageControl!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var facebookButton: UIButton!
    
    
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
    
    @IBAction func loginUsingFacebook(_ sender: UIButton) {
        let loginManager = FBSDKLoginManager()
        loginManager.loginBehavior = FBSDKLoginBehavior.browser
        if FBSDKAccessToken.current() == nil {
            loginManager.logIn(withReadPermissions: ["public_profile","email","user_friends"], from: self, handler: { (result, error) -> Void in
                if error != nil {
                    self.showAlertMessage(title: error!.localizedDescription, message: nil)
                } else if result!.isCancelled {
                    self.showAlertMessage(title: "Unable to login. Please try again", message: nil)
                } else {
                    if result!.grantedPermissions.contains("email") {
                        print("Successfully loggedIn")
                        let userId = result!.token.userID
                        let token = result!.token.tokenString
                        print(userId)
                        print(token)
                        
                        self.setUserDetails(userId: userId!, token: token!)
                    } else {
                        self.showAlertMessage(title: "Unable to get email. Please try again", message: nil)
                    }
                }
                })
        } else {
            let userId = FBSDKAccessToken.current()!.userID
            let token = FBSDKAccessToken.current()!.tokenString
            
            print(userId)
            print(token)
            print("already logged in user")
            self.setUserDetails(userId: userId!, token: token!)
        }
    }
    
    func loginUser(result:FBSDKLoginManagerLoginResult) {
        let userId = result.token.userID
        let token = result.token.tokenString
        if userId == nil || token == nil {
            self.showAlertMessage(title: "Unable to get user id or token. Please try again", message: nil)
            return
        }
        setUserDetails(userId: userId!, token: token!)
    }
    
    func setUserDetails(userId: String, token: String) {
//        print(userId)
//        print(token)
        APIService.facebookLogin(fbUserId: userId, fbUserToken: token, completion: {success,msg,json in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.signUpCompleted()
            }
        })
    }
    
    func signUpCompleted() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasicInfoViewController") as? BasicInfoViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
