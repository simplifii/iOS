//
//  SubmitResultViewController.swift
//  MacroFit
//
//  Created by ajay dubedi on 02/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class SubmitResultViewController: UIViewController{
    
    
    @IBOutlet weak var minut: UIButton!
    @IBOutlet weak var second: UIButton!
    
    var isSecond = false
    var isMinut = false
    var selectedMinut:Int = 0
    var selectedSecond:Int = 0
    var challengeId = ""
    var challengeTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnCancel(_ sender: UIButton) {
       
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnMinut(_ sender: UIButton) {
        isSecond = false
        isMinut = true
        let popupvc = UIStoryboard(name: "Challenges", bundle: nil
            ).instantiateViewController(withIdentifier: "selectValuePopup") as! selectValuePopup
        popupvc.delegate = self
        self.addChildViewController(popupvc)
        popupvc.view.frame = self.view.frame
        self.view.addSubview(popupvc.view)
        popupvc.didMove(toParentViewController: self)
    }
    
    @IBAction func btnSecond(_ sender: UIButton) {
        isSecond = true
        isMinut = false
        let popupvc = UIStoryboard(name: "Challenges", bundle: nil
            ).instantiateViewController(withIdentifier: "selectValuePopup") as! selectValuePopup
        popupvc.delegate = self
        self.addChildViewController(popupvc)
        popupvc.view.frame = self.view.frame
        self.view.addSubview(popupvc.view)
        popupvc.didMove(toParentViewController: self)
    }
    
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        let score = String(selectedMinut * 60 + selectedSecond)
       
        APIService.SubmitScore(score:score,challenge:challengeId, completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            }
            else
            {
                
                for (_,item) in data {
                    if (item["users_best"].boolValue == true) {
                        let vc = UIStoryboard(name: "Challenges", bundle: nil).instantiateViewController(withIdentifier: "BestRecordViewController") as? BestRecordViewController
                        vc?.bestScore = item["score_formatted"].stringValue
                        vc?.userLastBestScore = item["prev_best"].stringValue
                        vc?.challengeTitle = self.challengeTitle
                        self.navigationController?.isNavigationBarHidden = true
                        self.navigationController?.pushViewController(vc!, animated: true)
                        
                    } else {
                        self.navigationController?.popViewController(animated: false)
                    }
                }
               
            }
        })
    }
    
    //function to show alert message
    func showAlertMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        action.setValue(ColorConstants.schemeColor, forKey: "titleTextColor")
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}

extension SubmitResultViewController:selectedValue1
{
    func selectedValue1(value1: String) {
        if isMinut{
           minut.setTitle(value1, for: .normal)
            selectedMinut = Int(value1) ?? 0
        }else
        {
            second.setTitle(value1, for: .normal)
            selectedSecond = Int(value1) ?? 0
        }
        
        isMinut = false
        isSecond = false
       
    }
    
    
}


