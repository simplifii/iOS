//
//  SelectProfilePhotoViewController.swift
//  MacroFit
//
//  Created by Chandresh on 30/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import CropViewController

class SelectProfilePhotoViewController: BaseViewController, CropViewControllerDelegate {
    
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackNavbarInView(navbarView: navbarView, settings_visible: false)
        
        skipButton.layer.cornerRadius = 8.0
        skipButton.layer.borderWidth = 1
        skipButton.layer.borderColor = Constants.buttonBorderColor.cgColor
    }
    
    @IBAction func selectImageSource(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "Upload image", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.openImagePickerWith(source: .camera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) -> Void in
            self.openImagePickerWith(source: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func openImagePickerWith(source: UIImagePickerController.SourceType)
    {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let cameraPickerController = UIImagePickerController()
            cameraPickerController.delegate = self;
            cameraPickerController.sourceType = source
            self.present(cameraPickerController, animated: true, completion: nil)
        } else {
            print("source not available")
        }
    }
    
    
    
    func openCropImageViewController(image: UIImage) {
        let cropViewController = CropViewController(image: image)
        cropViewController.delegate = self
        cropViewController.aspectRatioPreset = .presetSquare
        cropViewController.aspectRatioLockEnabled = true
        cropViewController.setAspectRatioPreset(.presetSquare, animated: true)
        cropViewController.aspectRatioPickerButtonHidden = true
        cropViewController.resetAspectRatioEnabled = false
        
        present(cropViewController, animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        dismiss(animated: true, completion: {
            print("done")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UploadProfilePhotoViewController") as? UploadProfilePhotoViewController
            vc?.image = self.resizeImage(image: image, newWidth: 500)
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
        })
    }
    
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if newImage != nil {
            return newImage!
        }
        return image
    }
    
    
    @IBAction func skipProfileUpload(_ sender: UIButton) {
        showWorkoutWithFriendsScreen()
    }
    
    
    func showWorkoutWithFriendsScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WorkoutWithFriendsViewController") as? WorkoutWithFriendsViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}


extension SelectProfilePhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.dismiss(animated: true, completion: {
                self.openCropImageViewController(image: image)
            })
        } else{
            print("Something went wrong")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}


