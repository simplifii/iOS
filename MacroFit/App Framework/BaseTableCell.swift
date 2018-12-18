//
//  BaseHomeCell.swift
//  Reach-Swift
//
//  Created by akash savediya on 02/08/17.
//  Copyright © 2017 Kartik. All rights reserved.
//

import UIKit

protocol BaseTableCell {
    func getCellType()->TableCellType
}

protocol CellActionListner {
    func onCellAction(actionType : CellAction, position : Int);
}

protocol ICollectionCell{
    func getCellType()->CollectionCellType
}
