//
//  CourseCompleteViewController.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/29/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class CourseCompleteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func closePressed(_ sender: UIButton) {
    }
    
}

class CourseSummaryTableViewCell: UITableViewCell {
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
}

class ShowCourseTableViewCell: UITableViewCell {
    @IBOutlet weak var checkImageView: UIImageView!
    
}

class RateCourseTableViewCell: UITableViewCell {
    @IBOutlet weak var starContainer: UIView!
    @IBOutlet weak var feedbackView: UITextView!
    
    @IBOutlet weak var sendMessageButton: UIButton!
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
    }
    
}

class ExerciseSummaryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    @IBOutlet weak var topLineLabel: UILabel!
    @IBOutlet weak var bottomLineLabel: UILabel!
}
