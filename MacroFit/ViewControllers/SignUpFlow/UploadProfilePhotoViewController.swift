//
//  UploadProfilePhotoViewController.swift
//  MacroFit
//
//  Created by Chandresh on 03/12/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class UploadProfilePhotoViewController: BaseViewController {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var image:UIImage!
    var uploadedImageUrl:String = ""
    var uploadedImageThumbnailUrl:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
        
        
        if image != nil {
            profilePhotoImageView.image = image
            uploadProfilePhoto()
        }
        
        activityIndicatorView.hidesWhenStopped = true
        
        imageViewHeightConstraint.constant = self.view.frame.width - 66
        profilePhotoImageView.layer.cornerRadius = (self.view.frame.width - 66)/2
        profilePhotoImageView.clipsToBounds = true
        
        
        skipButton.layer.cornerRadius = 8.0
        skipButton.layer.borderWidth = 1
        skipButton.layer.borderColor = Constants.buttonBorderColor.cgColor
    }

    @IBAction func contiueToUploadPhoto(_ sender: UIButton) {
        updateProfilePic()
    }
    
    @IBAction func skipUploadingPhoto(_ sender: UIButton) {
        showNextScreen()
    }
    
    func showNextScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WorkoutWithFriendsViewController") as? WorkoutWithFriendsViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func uploadProfilePhoto() {
        showLoader()

        APIService.uploadImage(image: image, completion: {success,msg,data in
            self.hideLoader()
            if success == true {
                self.uploadedImageUrl = data["url"].stringValue
                self.uploadedImageThumbnailUrl = data["thumbnail"].stringValue
            } else {
                self.showAlertMessage(title: msg, message: nil)
            }
        })
    }
    
    func showLoader() {
        activityIndicatorView.startAnimating()
        skipButton.isUserInteractionEnabled = false
        continueButton.isUserInteractionEnabled = false
    }
    func hideLoader() {
        activityIndicatorView.stopAnimating()
        skipButton.isUserInteractionEnabled = true
        continueButton.isUserInteractionEnabled = true
    }
    
    func updateProfilePic() {
        APIService.updateProfilePic(imageUrl: uploadedImageUrl, thumbnailUrl: uploadedImageThumbnailUrl, completion: {success,msg in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            } else {
                self.showNextScreen()
            }
        })
    }
}
