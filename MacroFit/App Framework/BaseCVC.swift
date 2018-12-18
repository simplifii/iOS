//
//  BaseCVC.swift
//  BrewBound
//
//  Created by Nitin Bansal on 18/10/17.
//  Copyright © 2017 Nitin Bansal. All rights reserved.
//

import UIKit

class BaseCVC: UICollectionViewCell {
    var cellActionDelegate : CellActionListner?
    var position : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayData(model : ICollectionCell){
        print("Display data of Base CVC")
    }
    
    
    
    func onAction(actionType : CellAction){
        if let delegate = cellActionDelegate{
            delegate.onCellAction(actionType: actionType, position: position)
        }
    }
}
