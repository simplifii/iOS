//
//  BaseFilter.swift
//  Jugo
//
//  Created by akash savediya on 04/11/17.
//  Copyright © 2017 akash savediya. All rights reserved.
//

import Foundation


class BaseFilter : BaseTableCell {
    
    
    
    func getCellType() -> TableCellType {
        return TableCellType.SELECT_FILTER
    }
    
}

public protocol IFilter{
    func getDisplayString()->String
}
