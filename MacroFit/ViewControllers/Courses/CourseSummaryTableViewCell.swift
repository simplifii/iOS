//
//  CourseSummaryTableViewCell.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 11/30/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class CourseSummaryTableViewCell: UITableViewCell {
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var exercisesJSON: [JSON]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CourseSummaryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercisesJSON?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCell", for: indexPath) as! ExerciseSummaryCollectionViewCell
        
        
        if let exercise = exercisesJSON?[indexPath.row] {
            var values = [String]()
            cell.exerciseNameLabel.text = exercise["title"].string
            if let reps = exercise[ExerciseManager.ActualRepsKey].int ?? exercise["recommended_reps"].int {
                values.append("x\(reps)")
            }
            if let time = exercise[ExerciseManager.ActualTimeKey].double ?? exercise["recommended_duration_in_secs"].double {
                values.append(MFTimeFormatter.formatter.clockStyleDurationString(fromSeconds: time))
            }
            if let weight = exercise[ExerciseManager.ActualWeightKey].double ?? exercise["recommended_weight_in_gms"].double,
                let wtString = MFNumberFormatter.formatter.stringFromWeight(grams: weight) {
                values.append(wtString + MFNumberFormatter.formatter.weightUnitString)
            }
            
            var i = 0
            for label in [cell.topLineLabel, cell.bottomLineLabel] {
                if values.count > i { label?.text = values[i] }
                i += 1
            }
        }
        return cell
    }
    
    
}

class ExerciseSummaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var topLineLabel: UILabel!
    @IBOutlet weak var bottomLineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearFields()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearFields()
    }
    
    func clearFields() {
        exerciseNameLabel.text = nil
        topLineLabel.text = nil
        bottomLineLabel.text = nil
    }
}
