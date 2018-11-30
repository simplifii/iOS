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
    
    var exercisesJSON: [JSON]?
    
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
            cell.exerciseNameLabel.text = exercise["title"].string
            cell.topLineLabel.text = "x3"
            cell.bottomLineLabel.text = "03:24"
        }
        return cell
    }
    
    
}
