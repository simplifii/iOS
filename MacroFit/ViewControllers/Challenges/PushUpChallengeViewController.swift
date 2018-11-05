//
//  PushUpChallengeViewController.swift
//  MacroFit
//
//  Created by ajay dubedi on 30/10/18.
//  Copyright 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class PushUpChallengeViewController: UIViewController {
    
    var isStatistics:Bool = true
    var isLeaderboard:Bool = false
    @IBOutlet weak var viewStatistics: UIView!
    @IBOutlet weak var btnStatistics: UIButton!
    @IBOutlet weak var viewLeaderboard: UIView!
    @IBOutlet weak var btnLeaderboard: UIButton!
    @IBOutlet weak var btnSubmitNewResult: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblParticipantsCount: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var yourLastResultViewHide: UIView!
    
    var getScore = [GetScore]()
    var getEachUserScore = [GetEachUserBestScore]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopSpacing: NSLayoutConstraint!
    var challengePhoto:Data?
    var challengeTitle:String?
    var challengeDescription:String?
    var challengeParticipants_count:String?
    var challengeId:String?
    var challengeIs_scoring_in_time:Bool?
    var challengeScore_unit:String?
    let userId = UserDefaults.standard.string(forKey: "\(UserConstants.userId)")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnStatistics.setTitleColor(UIColor(displayP3Red: 235/255, green: 84/255, blue: 40/255, alpha: 1), for: .normal)
        tableView.tableFooterView = UIView(frame: .zero)
        lblTitle.text = challengeTitle
        lblDescription.text = challengeDescription
        lblParticipantsCount.text = " \(challengeParticipants_count ?? "")"
        imageBackground.image = UIImage(data:challengePhoto!)
        viewStatistics.backgroundColor = UIColor(displayP3Red: 235/255, green: 84/255, blue: 40/255, alpha: 1)
        viewLeaderboard.backgroundColor = UIColor(displayP3Red: 252/255, green: 250/255, blue: 252/255, alpha: 1)
        getUserChallengeScore()
        getEachUserBestScore()
    }
    //MARK: get the all list getUserChallengeScore
    func getUserChallengeScore()
    {
        APIService.getChallengeScore(equalto___challenge:challengeId, creator: userId,completion: {success,msg,data in
            if success == true {
                if data.count > 0
                {
                    
                    self.getScore.removeAll()
                    for (_,item) in data {
                        let getScore = GetScore()
                        let dateFormatterGet = DateFormatter()
                        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let dateFormatterPrint = DateFormatter()
                        dateFormatterPrint.dateFormat = "dd MMMM, EEEE"
                        
                        if let date = dateFormatterGet.date(from:item["created_at"].stringValue) {
                            getScore.created_at = dateFormatterPrint.string(from: date)
                        }
                        
                        getScore.score_formatted = item["score_formatted"].stringValue
                        getScore.users_best = item["users_best"].boolValue
                        self.getScore.append(getScore)
                    }
//                    self.tableViewHeight.constant = 168
                    self.loadViewIfNeeded()
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    //MARK: get the all list getEachUserBestScore
    func getEachUserBestScore()
    {
      
        
        APIService.getEachUserBestScore(equalto___challenge:challengeId,completion: {success,msg,data in
            if success == true {
                if data.count > 0 {
                 
                    for (_,item) in data {
                        let eachUserScore = GetEachUserBestScore()
                        eachUserScore.fk_creator = item["fk_creator"].stringValue
                        eachUserScore.score_formatted = item["score_formatted"].stringValue
                        eachUserScore.name = item["creator"]["name"].stringValue
                        self.getEachUserScore.append(eachUserScore)
                    }
                    self.yourLastResultViewHide.isHidden = false
                    self.tableView.reloadData()
                } else {
                    self.yourLastResultViewHide.isHidden = true
                }
            }
        })
    }
    
    
    //function to show alert message
    func showAlertMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        action.setValue(Constants.schemeColor, forKey: "titleTextColor")
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func actionStatistics(_ sender: UIButton) {
        isStatistics = true
        isLeaderboard = false
        yourLastResultViewHide.isHidden = false
        tableViewTopSpacing.constant = 98
//        self.tableViewHeight.constant = 168
        btnStatistics.setTitleColor(UIColor(displayP3Red: 235/255, green: 84/255, blue: 40/255, alpha: 1), for: .normal)
        
        btnLeaderboard.setTitleColor(UIColor(displayP3Red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
        
        viewStatistics.backgroundColor = UIColor(displayP3Red: 235/255, green: 84/255, blue: 40/255, alpha: 1)
        viewLeaderboard.backgroundColor = UIColor(displayP3Red: 252/255, green: 251/255, blue: 252/255, alpha: 1)
        self.loadViewIfNeeded()
        tableView.reloadData()
        
        
    }
    
    @IBAction func actionLeaderboard(_ sender: UIButton) {
        isStatistics = false
        isLeaderboard = true
        yourLastResultViewHide.isHidden = true
        tableViewTopSpacing.constant = 0
//        tableViewHeight.constant = 269
        
        btnLeaderboard.setTitleColor(UIColor(displayP3Red: 235/255, green: 84/255, blue: 40/255, alpha: 1), for: .normal)
        
        btnStatistics.setTitleColor(UIColor(displayP3Red: 153/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)
        
        
        viewStatistics.backgroundColor =  UIColor(displayP3Red: 252/255, green: 251/255, blue: 252/255, alpha: 1)
        viewLeaderboard.backgroundColor = UIColor(displayP3Red: 235/255, green: 84/255, blue: 40/255, alpha: 1)
        
        self.loadViewIfNeeded()
        tableView.reloadData()
        
    }
    
    @IBAction func actionSubmitNewResult(_ sender: UIButton) {
        if (challengeIs_scoring_in_time == true)
        {
        let vc = UIStoryboard(name: "Challenges", bundle: nil).instantiateViewController(withIdentifier: "SubmitResultViewController") as? SubmitResultViewController
        vc?.challengeId = challengeId ?? ""
            vc?.challengeTitle = challengeTitle ?? ""
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
        }else
        {
           //write the code for new page to open
            let vc = UIStoryboard(name: "Challenges", bundle: nil).instantiateViewController(withIdentifier: "SubmitWhenScoreIsInValueViewController") as? SubmitWhenScoreIsInValueViewController
            vc?.challengeId = challengeId ?? ""
            vc?.challengeTitle = challengeTitle ?? ""
            vc?.scoreUnit = challengeScore_unit
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    
    
    
    
    
}

extension PushUpChallengeViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getScore.count > 0 || getEachUserScore.count > 0
        {
            if isLeaderboard
            {
                return getEachUserScore.count
                
            }else
            {
                return getScore.count
            }
        }else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if getScore.count > 0 || getEachUserScore.count > 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? LeaderBoardTableViewCell  //shouldn't this be withIdentifier: "cell"
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell") as? StatisticsTableViewCell
            if isLeaderboard {
                if (getEachUserScore[indexPath.row].fk_creator == userId) {
                    cell?.name.text = "You"
                } else {
                    cell?.name.text = getEachUserScore[indexPath.row].name
                }
                cell?.count.text = "\(indexPath.row + 1)"
                cell?.score.text = getEachUserScore[indexPath.row].score_formatted
                return cell!                
            } else {
                yourLastResultViewHide.isHidden = false
                cell1?.lblDate.text = getScore[indexPath.row].created_at
                cell1?.lblResult.text = getScore[indexPath.row].score_formatted
                if (getScore[indexPath.row].users_best! == true) {
                    cell1?.userScoreUIView.backgroundColor = UIColor(displayP3Red: 241/255, green: 251/255, blue: 244/255, alpha: 1)
                }
                return cell1!
            }
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3")
            yourLastResultViewHide.isHidden = true
//            tableViewHeight.constant = 269
            self.loadViewIfNeeded()
            cell!.separatorInset = UIEdgeInsetsMake(0.0, cell!.bounds.size.width, 0.0, -cell!.bounds.size.width)
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if getScore.count > 0 || getEachUserScore.count > 0
        {
            if isLeaderboard
            {
                return 66
            }else
            {
                return  40
            }
        }else
        {
            return 121
        }
        
    }
    
    
}
