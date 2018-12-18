//
//  VCUtil.swift
//  BrewBound
//
//  Created by Nitin Bansal on 29/05/17.
//  Copyright © 2017 Nitin Bansal. All rights reserved.
//

import UIKit
import SDWebImage
class VCUtil: NSObject {
    
    static func getStoryBoard(name : String)->UIStoryboard{
        return UIStoryboard(name: name, bundle: nil)
    }
    
    static func getViewController(storyBoardName: String, identifier : String)->UIViewController{
        return getStoryBoard(name : storyBoardName).instantiateViewController(withIdentifier: identifier)
    }
    
    static func getViewController(storyBoard: UIStoryboard, identifier : String)->UIViewController{
        return storyBoard.instantiateViewController(withIdentifier: identifier)
    }
    
//    static func getViewController(identifier : String)->UIViewController{
//        return getStoryBoard(name: "Main").instantiateViewController(withIdentifier: identifier)
//    }
    
    static func isValidEmail(_ testStr : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    static func openLink(link: String){
        UIApplication.shared.open(URL.init(string: link)!)
    }
    
    static func isStringContainsOnlyNumbers(_ string: String) -> Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
    }
    
    //    static func getDrawerVC(nibName : String)->DrawerVC{
    //        return DrawerVC(nibName: "DrawerVC", bundle: nil);
    //    }
    
    static func setPlaceHolderColor(textFields : [UITextField]){
        for textField in textFields{
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(hex: "ffffff") ])
        }
        
    }
    static func setImage(url : String?, imageView : UIImageView){
        setImage(url: url, imageView: imageView, placeHolder: "male")
    }
    
    static func setImage(url : String?, imageView : UIImageView, placeHolder : String){
        if var imageUrl = url{
            if !imageUrl.isEmpty{
                imageUrl = getHttpUrl(imageUrl)
                //print("image url = "+imageUrl)
                imageView.sd_setImage(with: Foundation.URL.init(string: imageUrl), placeholderImage: UIImage.init(named: placeHolder), options: SDWebImageOptions.delayPlaceholder, completed: nil)
                
                return;
            }else{
                imageView.image = UIImage.init(named: placeHolder)
            }
        }else{
            imageView.image = UIImage.init(named: placeHolder)
        }
    }
    
    static func setImage(url : String?, imageView : UIImageView, placeHolder : UIImage){
        if var imageUrl = url{
            if !imageUrl.isEmpty{
                imageUrl = getHttpUrl(imageUrl)
                //print("image url = "+imageUrl)
                imageView.sd_setImage(with: Foundation.URL.init(string: imageUrl), placeholderImage: placeHolder, options: SDWebImageOptions.delayPlaceholder, completed: nil)
                
                return;
            }else{
                imageView.image = placeHolder
            }
        }else{
            imageView.image = placeHolder
        }
    }
    
    static func getHttpUrl(_ url : String)->String{
        if url.hasPrefix("http://"){
            return url.replacingOccurrences(of: "http://", with: "https://")
        }
        return url;
    }
    
//    static func getRelativeTimeString(serverTimeInMillis : Int64)->String{
//        let time = NSDate(timeIntervalSince1970: TimeInterval(serverTimeInMillis/1000)).timeIntervalSinceNow
//        let relativeTime = NSDate.relativeTimeInString(value: time)
//        if relativeTime.contains("week"){
//            return DateUtil.convertTimeToDateString(timeInMillis: serverTimeInMillis, convertFormat: DateUtil.UI_DATE_FORMAT)
//        }
//        return relativeTime;
//    }
    
    static func showActionSheet(list : [IFilter], delegate : ActionItemClickListener, _ taskCode : Int)->UIAlertController{
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        for item in list{
            alert.addAction(UIAlertAction(title: item.getDisplayString(), style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                delegate.onActionItemClicked(item, taskCode: taskCode);
            }));
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        return alert;
    }
    
    static func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

