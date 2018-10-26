//
//  RatingAndTextFeedbackViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 25/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class RatingAndTextFeedbackViewController: FeedbackPopupBaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var containerView: UIView!
    
    var uniqueCode = ""
    var thankYouPopupDelegate: ThankYouPopupDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 8.0
        showAnimate()
        feedbackTextView.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        removeAnimate()
    }
    @IBAction func sendFeedback(_ sender: UIButton) {
        editAppFeedback()
        
        removeAnimate()
    }
    
    
    func editAppFeedback() {
        let feedback = feedbackTextView.text!
        if !feedback.isEmpty {
            APIService.editFeedback(uniqueCode: uniqueCode, feedback: feedback, completion: {success,msg in
                if success == false {
                    self.showAlertMessage(title: msg, message: nil)
                } else {
                    self.thankYouPopupDelegate.showThankPopup()
                }
            })
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if feedbackTextView.text == "Type your feedback here" {
            feedbackTextView.text = ""
            feedbackTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if feedbackTextView.text.isEmpty {
            feedbackTextView.text = "Type your feedback here"
            feedbackTextView.textColor = UIColor.gray
        }
    }
    
}
