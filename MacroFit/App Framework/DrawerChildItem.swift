//
//  DrawerChildItem.swift
//  MacroFit
//
//  Created by mac on 12/14/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class DrawerChildItem: NSObject {
    var title : String!
    var index : DrawerIndex!
    var vcIdentifier: VCIdentifiers?
    
    static func getListForConference()->[DrawerChildItem]{
        var list = [DrawerChildItem]()
//        list.append(self.getItem(title: NSLocalizedString("about", comment: ""), index: DrawerIndex.ABOUT, VCIdentifiers.ABOUT))
//        list.append(self.getItem(title: NSLocalizedString("why_attend", comment: ""), index: DrawerIndex.WHY_ATTEND, VCIdentifiers.WHY_ATTEND))
//        list.append(self.getItem(title: NSLocalizedString("agenda", comment: ""), index: DrawerIndex.AGENDA, VCIdentifiers.AGENDA_PAGER_VC))
//        list.append(self.getItem(title: NSLocalizedString("speakers", comment: ""), index: DrawerIndex.SPEAKERS, VCIdentifiers.SPEAKERS))
//        list.append(self.getItem(title: NSLocalizedString("year_in_review", comment: ""), index: DrawerIndex.YEARS_IN_REVIEW, VCIdentifiers.YEARS_IN_REVIEW))
//        list.append(self.getItem(title: NSLocalizedString("how_to_get_there", comment: ""), index: DrawerIndex.HOW_TO_GET_THERE, VCIdentifiers.HOW_TO_GET_THERE))
        return list;
    }
    
    static func getListForInfo()->[DrawerChildItem]{
        var list = [DrawerChildItem]()
//        list.append(self.getItem(title: NSLocalizedString("while_in_dubai", comment: ""), index: DrawerIndex.WHILE_IN_DUBAI, VCIdentifiers.WHILE_IN_DUBAI))
//        list.append(self.getItem(title: NSLocalizedString("terms_amp_conditions", comment: ""), index: DrawerIndex.TERMS_AND_CONDITIONS, VCIdentifiers.TERMS_AND_CONDITIONS))
        //        list.append(self.getItem(title: "FAQS", index: DrawerIndex.FAQ, VCIdentifiers.FAQ))
        return list;
    }
    
    static func getItem(title : String, index : DrawerIndex, _ id: VCIdentifiers)->DrawerChildItem{
        let homeItem = DrawerChildItem();
        homeItem.title = title
        homeItem.index = index;
        homeItem.vcIdentifier = id;
        return homeItem;
    }
    
}

extension DrawerChildItem: BaseTableCell{
    func getCellType() -> TableCellType {
        return TableCellType.DRAWER_CHILD_ITEM
    }
}
