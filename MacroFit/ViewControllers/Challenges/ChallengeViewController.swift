//
//  ChallengeViewController.swift
//  MacroFit
//
//  Created by ajay dubedi on 24/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChallengeViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextBox: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var challengeTableData = [Challenge]()
    var challengTagData = [ChallengeTags]()
    
    //check the commit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextBox.delegate = self
        searchTextBox.layer.shadowColor = UIColor.lightGray.cgColor
        searchTextBox.layer.shadowRadius = 15.0
        searchTextBox.layer.shadowOpacity = 0.15
        searchTextBox.layer.masksToBounds = false
        getChallenges()
        getChallengesTags()
        // Do any additional setup after loading the view.
    }
    
    //MARK: get the all list of Challenges
    func getChallenges() {
        APIService.getListOfChallenges(completion: {success,msg,data in
            if success == true {
                if data.count > 0
                {
                    self.challengeTableData.removeAll()
                for (_,item) in data {
                    let challenge = Challenge()
                    challenge.id = item["id"].stringValue
                    challenge.title = item["title"].stringValue
                    challenge.description = item["description"].stringValue
                    challenge.participants_count = item["participants_count"].stringValue
                    challenge.id = item["id"].stringValue
                    challenge.is_scoring_in_time = item["is_scoring_in_time"].boolValue
                    challenge.score_unit = item["score_unit"].stringValue
                    let img = item["photo"].stringValue
                    do{
                        let urL = URL(string:img )
                        let data = try Data(contentsOf: urL!)
                        challenge.photo = data
                    }catch let Error {
                        print("Error:\(Error.localizedDescription)")
                    }
                    
                    self.challengeTableData.append(challenge)
                }
                self.tableView.reloadData()
                }else
                {
                   self.showAlertMessage(title: "No Result Found", message: nil)
                }
            } else {
                self.showAlertMessage(title: msg, message: nil)
                
            }
        })
    }
    
    //MARK: get the all list of ChallengesTags
    func getChallengesTags()
    {
        APIService.getChallengeTags(completion: {success,msg,data in
            if success == true {
                if data.count > 0
                {
                    self.challengTagData.removeAll()
                for (_,item) in data {
                    let challengeTags = ChallengeTags()
                    challengeTags.label = item["label"].stringValue
                    self.challengTagData.append(challengeTags)
                }
                self.collectionView.reloadData()
                }else
                {
                    self.showAlertMessage(title: "No Tag Found", message: nil)
                }
            } else {
                self.showAlertMessage(title: msg, message: nil)
                
            }
        })
    }
    
    //MARK: get the all list of ChallengesSearch
    func getChallengeSearch(searchString:String)
    {
        APIService.getChallengeSearch(searchString: searchString,completion: {success,msg,data in
            if success == true {
                if data.count > 0
                {
                    self.challengeTableData.removeAll()
                    for (_,item) in data {
                        let challenge = Challenge()
                        challenge.id = item["id"].stringValue
                        challenge.title = item["title"].stringValue
                        challenge.description = item["description"].stringValue
                        challenge.participants_count = item["participants_count"].stringValue
                        challenge.id = item["id"].stringValue
                        challenge.is_scoring_in_time = item["is_scoring_in_time"].boolValue
                        challenge.score_unit = item["score_unit"].stringValue
                        let img = item["photo"].stringValue
                        do{
                            let urL = URL(string:img )
                            let data = try Data(contentsOf: urL!)
                            challenge.photo = data
                        }catch let Error {
                            print("Error:\(Error.localizedDescription)")
                        }
                        self.challengeTableData.append(challenge)
                    }
                    self.tableView.reloadData()
                }else{
                    self.showAlertMessage(title: "No Result Found", message: nil)
                }
                
            } else {
                self.showAlertMessage(title: msg, message: nil)
                
            }
        })
    }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: false)
    }
    
    
    //function to show alert message
    func showAlertMessage(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        action.setValue(Constants.schemeColor, forKey: "titleTextColor")
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    

}


//MARK: tableview data source and delegate
extension ChallengeViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChallengeTableViewCell
        cell.title.text = challengeTableData[indexPath.row].title
        cell.backgroundImage.image = UIImage(data: challengeTableData[indexPath.row].photo!)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Challenges", bundle: nil).instantiateViewController(withIdentifier: "PushUpChallenge") as? PushUpChallengeViewController
        vc?.challengeTitle = challengeTableData[indexPath.row].title
        vc?.challengeParticipants_count = challengeTableData[indexPath.row].participants_count
        vc?.challengeDescription = challengeTableData[indexPath.row].description
        vc?.challengePhoto = challengeTableData[indexPath.row].photo!
        vc?.challengeId = challengeTableData[indexPath.row].id!
        vc?.challengeScore_unit = challengeTableData[indexPath.row].score_unit
        vc?.challengeIs_scoring_in_time = challengeTableData[indexPath.row].is_scoring_in_time
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    
}

//MARK:textfield datasource and delegate
extension ChallengeViewController:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ( searchTextBox.text! != "")
        {
            getChallengeSearch(searchString: searchTextBox.text!)
        }else
        {
            getChallenges()
        }
        textField.resignFirstResponder()
        return true
    }
    
 
}

//MARK:collectionView datasource and delegate
extension ChallengeViewController:UICollectionViewDataSource,UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challengTagData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ChallengeTagsCollectionViewCell
        cell?.ContainerView.layer.cornerRadius = 10
        cell?.ContainerView.layer.masksToBounds = true;
        cell?.tagTitle.text = challengTagData[indexPath.item].label
        
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchTextBox.text = challengTagData[indexPath.item].label
        getChallengeSearch(searchString: challengTagData[indexPath.item].label ?? "")
    }
    
}
