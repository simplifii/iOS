//
//  WorkoutCourseTVC.swift
//  MacroFit
//
//  Created by mac on 12/14/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class WorkoutCourseTVC: BaseTVC {

    var data:CourseModel!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var lockWidth: NSLayoutConstraint!
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var freeOrPremium: UIButton!
    @IBOutlet weak var freeOrPremiumWidth: NSLayoutConstraint!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var trainerName: UILabel!
    @IBOutlet weak var tags: UILabel!
    
    func setViews(){
        VCUtil.setImage(url: data.photo, imageView: bg)
//        bg.image = processVintageImage(bg.image!)
        title.text = data.title
        trainerName.text = data.trainerName
        tags.text = data.tags
        
        if data.priceInCents == 0{
            lockWidth.constant = 0
        }
        else{
            freeOrPremium.setTitle("PREMIUM", for: .normal)
            freeOrPremium.setTitle("PREMIUM", for: .focused)
            freeOrPremium.setTitle("PREMIUM", for: .highlighted)
            freeOrPremium.setTitle("PREMIUM", for: .selected)
            
            freeOrPremium.setBackgroundImage(UIImage(named: "premium"), for: .normal)
            freeOrPremium.setBackgroundImage(UIImage(named: "premium"), for: .focused)
            freeOrPremium.setBackgroundImage(UIImage(named: "premium"), for: .highlighted)
            freeOrPremium.setBackgroundImage(UIImage(named: "premium"), for: .selected)
            
            freeOrPremiumWidth.constant = 100
        }
        setGradient()
    }

    override func displayData(model: BaseTableCell) {
        data = model as? CourseModel
        setViews()
        container.showShadow(offset: 0.5, opacity: 0.2)
    }
    
    func processVintageImage(_ image: UIImage) -> UIImage {
        
        guard let inputImage = CIImage(image: image) else { return image }
        
        guard let photoFilter = CIFilter(name: "CIPhotoEffectInstant",
                                         withInputParameters: ["inputImage" : inputImage]),
            let photoOutput = photoFilter.outputImage,
            let sepiaFilter = CIFilter(name: "CISepiaTone",
                                       withInputParameters: ["inputImage": photoOutput]),
            let sepiaFilterOutput = sepiaFilter.outputImage,
            let vignetteFilter = CIFilter(name: "CIVignette",
                                          withInputParameters: ["inputImage": sepiaFilterOutput, "inputRadius" : 1.5, "inputIntensity" : 4.0]),
            let vignetteFilterOutput = vignetteFilter.outputImage else { return image }
        
        let context = CIContext(options: nil)
        
        let cgImage = context.createCGImage(vignetteFilterOutput, from: inputImage.extent)
        
        return UIImage(cgImage: cgImage!)
    }
    
    func setGradient(){
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = bg.bounds
        gradientMaskLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradientMaskLayer.locations = [0, 0.7]
        gradientMaskLayer.startPoint = CGPoint(x:0,y:0.5)
        gradientMaskLayer.endPoint = CGPoint(x:1,y:0.5)
        
        bg.layer.mask = gradientMaskLayer
    }
}
