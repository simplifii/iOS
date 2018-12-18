//
//  BaseTableVC.swift
//  Reach-Swift
//
//  Created by akash savediya on 12/08/17.
//  Copyright © 2017 Kartik. All rights reserved.
//

import UIKit

class BaseTableVC: BaseVC, UITableViewDelegate, UITableViewDataSource, CellActionListner {
    
    var list = [BaseTableCell]();
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func getTableView()->UITableView?{
        return nil;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCellView(indexPath: indexPath, tableView: tableView) as! BaseTVC
        let model = list[indexPath.row];
        cell.displayData(model: model)
        cell.cellActionDelegate = self;
        cell.position = indexPath.row;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellHeight(indexPath: indexPath);
    }
    
    func getCellView(indexPath : IndexPath, tableView : UITableView)->UITableViewCell{
        let cellModel : BaseTableCell = list[indexPath.row]
        let nibName : String = getCellNibName(cellType: cellModel.getCellType())
        let cell = getCellFromNibName(nibName: nibName)
        //        let cell = getCellFromIdentifier(nibName, indexPath) as! BaseTVC
        cell.updateConstraintsIfNeeded()
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.clear
        return cell;
    }
    
    //    func getCellFromIdentifier(_ identifier: String, _ indexPath : IndexPath) -> UITableViewCell {
    //        if let tableView = getTableView(){
    //            return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    //        }
    //        return getCellFromNibName(nibName: identifier)
    //    }
    
    func getCellNibName(cellType : TableCellType)->String{
        switch cellType {
        case .COURSE:
            return "WorkoutCourseTVC"
        case .CHALLENGE:
            return "WorkoutChallengeTVC"
//        case .DRAWER_HEADER:
//            nibName = "HeaderTVC"
//            break
//        case .DRAWER_ITEM:
//            nibName = "ExpandableTVC"
//            break
//        case .DRAWER_CHILD_ITEM:
//            nibName = "ExpandedTVC"
//            break
//        case .MY_EVENT:
//            nibName = "MyEventsTVC"
//            break
//        case .WISHLIST_PRODUCT:
//            nibName = "GeneralWishListTVC"
//            break
//        case .TRANSACTIONS:
//            nibName = "MyTransactionsTVC"
//            break
//        case .NOTIFICATION:
//            nibName = "NotificationTVC"
//            break
//        case .ABOUT_HEADER:
//            nibName = "AboutHeaderTVC"
//            break;
//        case .ABOUT_SUBHEADING:
//            nibName = "AboutSubheadingTVC"
//            break;
//        case .ABOUT_INFO:
//            nibName = "AboutInfoTVC"
//            break
//        case .ABOUT_BULLET:
//            nibName = "AboutBulletTVC"
//            break;
//        case .ABOUT_STATS_ONE:
//            nibName = "AboutStatsTypeOneTVC"
//            break;
//        case .ABOUT_STATS_TWO:
//            nibName = "AboutStatsTypeTwoTVC"
//            break;
//        case .NETWORKING:
//            nibName = "NetworkingTVC"
//            break;
//        case .AGENDA_TITLE:
//            nibName = "AgendaTitleTVC"
//            break;
//        case .AGENDA_SPEAKER:
//            nibName = "AgendaSpeakerTVC"
//            break;
//        case .AGENDA_MODERATOR:
//            nibName = "AgendaModeratorTVC"
//            break;
//        case .YEARS_IN_REVIEW_HEADER:
//            nibName = "YearsInReviewHeaderTVC"
//            break;
//        case .YEARS_IN_REVIEW_BODY:
//            nibName = "YearsInReviewBodyTVC"
//        case .TERMS_AND_CONDITIONS:
//            nibName = "TermsAndConditionsTVC"
        default:
            return "";
        }
    }
    
    
    func getCellFromNibName(nibName : String)->UITableViewCell{
        let cell = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as! UITableViewCell;
        return cell;
    }
    
    func getCellHeight(indexPath : IndexPath)->CGFloat{
        let cellModel : BaseTableCell = list[indexPath.row]
        return getCellHeight(cellType: cellModel.getCellType())
    }
    
    func getCellHeight(cellType : TableCellType)->CGFloat{
        switch cellType {
//        case .DRAWER_HEADER:
//            return 130;
//        case .DRAWER_ITEM:
//            return 48;
//        case .DRAWER_CHILD_ITEM:
//            return 42;
        default:
            return UITableViewAutomaticDimension;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("You selected cell #\(indexPath.row)!")
        onCellClicked(indexPath : indexPath)
    }
    
    func onCellClicked(indexPath : IndexPath){
        
    }
    
    func onCellAction(actionType: CellAction, position: Int) {
        
    }
    
    func popOrDismiss(){
        if let nav = self.navigationController{
            nav.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellHeight(indexPath: indexPath)
    }
    
    func refreshTable(){
        DispatchQueue.main.async {
            self.getTableView()?.reloadData()
            self.getTableView()?.tableFooterView = UIView()
        }
    }
    
    func removeExtraDividers(){
        self.getTableView()?.tableFooterView = UIView()
    }
}

