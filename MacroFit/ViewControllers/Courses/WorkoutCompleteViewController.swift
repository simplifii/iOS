//
//  WorkoutCompleteViewController.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/29/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class WorkoutCompleteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(feedbackSent), name: .courseFeedbackSent, object: nil)
    }
    
    @objc func feedbackSent() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: {[weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        })
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension WorkoutCompleteViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return ExerciseManager.manager.numberOfRounds
        case 2: return 2
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "CongratsCell", for: indexPath)
        case 1:
            let roundCell = tableView.dequeueReusableCell(withIdentifier: "CourseSummary", for: indexPath) as! CourseSummaryTableViewCell
            roundCell.roundLabel.text = nil //Round \(indexPath.row + 1)"
            let exercisesJSON = ExerciseManager.manager.orderedExercises(in: indexPath.row)
            roundCell.exercisesJSON = exercisesJSON
            cell = roundCell
        default:
            switch indexPath.row {
//            case 0:
//                cell = tableView.dequeueReusableCell(withIdentifier: "ShowInFeed", for: indexPath)
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "ShareWithFriends", for: indexPath)
            default:
                cell = tableView.dequeueReusableCell(withIdentifier: "RateCourse", for: indexPath)
                (cell as? RateCourseTableViewCell)?.lessonID = ExerciseManager.manager.lessonID
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 2, indexPath.row == 0 else { return }
        
        let url = "https://macrofit.com/" //TODO change this to a course reference when that becomes available.
        
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
}

class ShowCourseTableViewCell: UITableViewCell {
    @IBOutlet weak var checkImageView: UIImageView!
    
}

class RateCourseTableViewCell: UITableViewCell {
    @IBOutlet weak var starContainer: UIView!
    @IBOutlet weak var feedbackView: UITextView!
    
    @IBOutlet weak var sendMessageButton: UIButton!
    var lessonID: Int = 0
    var rating: Int = 5
    
    private var ratingView: RatingView?
    
    fileprivate let placeholder = "Type your feedback here"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addRatingView()
        feedbackView.delegate = self
        feedbackView.text = placeholder
    }
    
    func addRatingView() {
        if ratingView != nil { return }
        ratingView = Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)?.first as? RatingView
        ratingView!.frame.size = starContainer.bounds.size
        starContainer.addSubview(ratingView!)
        ratingView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        ratingView!.starOneButton.addTarget(self, action: #selector(self.showRatingInRatingView(_:)), for: UIControlEvents.touchUpInside)
        ratingView!.startTwoButton.addTarget(self, action: #selector(self.showRatingInRatingView(_:)), for: UIControlEvents.touchUpInside)
        ratingView!.starThreeButton.addTarget(self, action: #selector(self.showRatingInRatingView(_:)), for: UIControlEvents.touchUpInside)
        ratingView!.starFourButton.addTarget(self, action: #selector(self.showRatingInRatingView(_:)), for: UIControlEvents.touchUpInside)
        ratingView!.starFiveButton.addTarget(self, action: #selector(self.showRatingInRatingView(_:)), for: UIControlEvents.touchUpInside)
    }
    
    @objc func showRatingInRatingView(_ sender: UIButton) {
        let r = Int(sender.accessibilityHint!)!
        rating = r
        ratingView!.setRating(rating: r)
        
    }
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        ExerciseManager.manager.sendFeedback(for: lessonID, stars: rating, feedback: feedbackView.text == placeholder ? "" : feedbackView.text)
        sender.isEnabled = false
        sender.setTitle("Feedback sent", for: .normal)
    }
}

extension RateCourseTableViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return textView.text.count + text.count - range.length <= 1000 //Server enforced max limit
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            textView.text = placeholder
        }
        
        textView.text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
