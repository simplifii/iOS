//
//  WorkoutVC.swift
//  MacroFit
//
//  Created by mac on 12/14/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class WorkoutsVC: BaseTableVC {

    static var responseResult:[BaseTableCell]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func getTableView() -> UITableView? {
        return tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    
    func initVC(){
        if WorkoutsVC.responseResult == nil{
            downloadData(httpRequest: ApiGenerator.getCoursesAndChallenges())
        }
        else{
            for item in WorkoutsVC.responseResult{
                self.list.append(item)
            }
            tableView.reloadWithAnimation()
        }
    }
    
    override func onSuccess(_ object: HttpResponse, forTaskCode taskcode: TASKCODES, httpRequestObject httpRequest: HttpObject) -> Bool {
        
        if super.onSuccess(object, forTaskCode: taskcode, httpRequestObject: httpRequest){
            switch taskcode{
                
            case .GET_COURSES_AND_CHALLENGES:
                onGetCoursesAndChallenges(object)
            default:return false
            }
            return true
        }
        return false
    }
    
    override func onCellClicked(indexPath : IndexPath){
        
        let modal = VCUtil.getViewController(storyBoardName: "Subscription", identifier: "UpgradeToPremiumVC")
        
        navigationController?.present(modal, animated: true, completion: nil)
    }
    
    fileprivate func onGetCoursesAndChallenges(_ object: HttpResponse) {
        let apiResponse = object.responseObject as? CoursesAndChallengesApiResponse
        
        if let response = apiResponse{
            let courses = response.response.courses
            let challenges = response.response.challenges
            
            var i=0,j=0
            
            if courses != nil && challenges != nil{
                while (i<courses!.count && j<challenges!.count){
                    self.list.append(courses![i])
                    self.list.append(challenges![j])
                    i+=1;j+=1;
                }
            }
            
            if courses != nil{
                if i<courses!.count{
                    while (i<courses!.count){
                        self.list.append(courses![i])
                        i+=1
                    }
                }
            }
            
            if challenges != nil{
                if j<challenges!.count{
                    while (j<challenges!.count){
                        self.list.append(challenges![j])
                        j+=1
                    }
                }
            }
            tableView.reloadWithAnimation()
        }
    }
}
