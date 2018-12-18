//
//  SubmitWhenScoreIsInValueViewController.swift
//  MacroFit
//
//  Created by ajay dubedi on 02/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class SubmitWhenScoreIsInValueViewController: UIViewController, selectedValue1 {

    
    @IBOutlet weak var scoreValueButton: UIButton!
    @IBOutlet weak var lblScoreUnit: UILabel!
    var challengeTitle = ""
    var scoreUnit:String?
    var challengeId:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblScoreUnit.text = scoreUnit
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    

    @IBAction func btnSubmit(_ sender: Any) {
        
        APIService.SubmitScore(score:scoreValueButton.currentTitle!,challenge:challengeId ?? "", completion: {success,msg,data in
            if success == false {
                self.showAlertMessage(title: msg, message: nil)
            }
            else
            {
                
                for (_,item) in data {
                    if (item["users_best"].boolValue == true)
                    {
                        let vc = UIStoryboard(name: "Challenges", bundle: nil).instantiateViewController(withIdentifier: "BestRecordViewController") as? BestRecordViewController
                        vc?.bestScore = item["score_formatted"].stringValue
                        vc?.userLastBestScore = item["prev_best"].stringValue
                        vc?.challengeTitle = self.challengeTitle
                        self.navigationController?.isNavigationBarHidden = true
                        self.navigationController?.pushViewController(vc!, animated: true)
                    }else
                    {
                        self.navigationController?.popViewController(animated: false)
                    }
                    
                    
                }
                
            }
        })
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
       
        self.view.endEditing(true)
    }
    
    
    //function to show alert message
    func showAlertMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        action.setValue(ColorConstants.schemeColor, forKey: "titleTextColor")
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func btnMinut(_ sender: UIButton) {
        let popupvc = UIStoryboard(name: "Challenges", bundle: nil
            ).instantiateViewController(withIdentifier: "selectValuePopup") as! selectValuePopup
        popupvc.maxValue = 100
        
        popupvc.delegate = self
        self.addChildViewController(popupvc)
        popupvc.view.frame = self.view.frame
        self.view.addSubview(popupvc.view)
        popupvc.didMove(toParentViewController: self)
    }
    
    
    func selectedValue1(value1: String) {
        scoreValueButton.setTitle(value1, for: .normal)
    }
    
}
