//
//  BaseTVC.swift
//  Reach-Swift
//
//  Created by akash savediya on 02/08/17.
//  Copyright © 2017 Kartik. All rights reserved.
//

import UIKit

class BaseTVC: UITableViewCell {

    var cellActionDelegate : CellActionListner?
    var position : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayData(model : BaseTableCell){
        print("Display data of Base TVC")
    }
    
    
    
    func onAction(actionType : CellAction){
        if let delegate = cellActionDelegate{
            delegate.onCellAction(actionType: actionType, position: position)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
