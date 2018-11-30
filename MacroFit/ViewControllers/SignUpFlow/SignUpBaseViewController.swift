//
//  SignUpBaseViewController.swift
//  MacroFit
//
//  Created by Chandresh on 30/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SignUpBaseViewController: OnboardUserViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func addFacebookIconInButton(button: UIButton) {
        let icon = resizeImage(image: UIImage(named: "facebook")!, targetSize: CGSize(width: 21, height: 21))
        button.setImage(icon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 50)
    }

    func loginWithFacebook() {
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
                        
                        self.setUserDetails(userId: userId!, token: token!)
                    } else {
                        self.showAlertMessage(title: "Unable to get email. Please try again", message: nil)
                    }
                }
            })
        } else {
            let userId = FBSDKAccessToken.current()!.userID
            let token = FBSDKAccessToken.current()!.tokenString
            
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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectProfilePhotoViewController") as? SelectProfilePhotoViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
