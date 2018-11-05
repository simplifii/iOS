//
//  BestRecordViewController.swift
//  MacroFit
//
//  Created by ajay dubedi on 02/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class BestRecordViewController: UIViewController {

    @IBOutlet weak var lblbestScore: UILabel!
    
    
    @IBOutlet weak var lastBestScore: UILabel!
    
    var bestScore = ""
    var userLastBestScore = ""
    var challengeTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      
        lastBestScore.text = userLastBestScore
        lblbestScore.text = bestScore
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func btnShare(_ sender: Any) {
        
        let UserBestScore = "Score: \(self.bestScore)"
        let message = "Hey, I achieved my best score ever in \(challengeTitle) on Macrofit app."
        let engMsg = "Would you take this challenge?"
        let shareVc = UIActivityViewController(activityItems: [message,UserBestScore,engMsg], applicationActivities: nil)
        shareVc.popoverPresentationController?.sourceView = self.view
        self.present(shareVc,animated: true,completion: nil)
        
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
       
        self.view.endEditing(true)
    }
    
   

}
