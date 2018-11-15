//
//  ChallengeViewController.swift
//  MacroFit
//
//  Created by ajay dubedi on 24/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON
import TagListView

class ChallengeViewController: UIViewController, TagListViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextBox: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fitnessHeadViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var categoriesTagListView: TagListView!
    @IBOutlet weak var chooseCategoriesLabel: UILabel!
    var selectedCategories:[String] = []
    var tagChallengesMapping:[String:[Int]] = [:]
    
    var challengesJsonData:JSON = []
    var challengeTableData = [Challenge]()
    var challengeData:[Int:Challenge] = [:]
    var challengTagData = [ChallengeTags]()
    
    //check the commit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextBox.delegate = self
        searchTextBox.layer.shadowColor = UIColor.lightGray.cgColor
        searchTextBox.layer.shadowRadius = 15.0
        searchTextBox.layer.shadowOpacity = 0.15
        searchTextBox.layer.masksToBounds = false
        
        if challengesJsonData.count == 0 {
            getChallenges()
        } else {
            self.setChallengesData(data: challengesJsonData)
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
        categoriesTagListView.delegate = self
   
        categoriesTagListView.textFont = UIFont.init(name: "Montserrat", size: 12)!
        categoriesTagListView.alignment = .left
    }
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print(title)
        removeCategory(category: title)
    }
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print(title)
        removeCategory(category: title)
    }
    
    //MARK: get the all list of Challenges
    func getChallenges() {
        APIService.getListOfChallenges(completion: {success,msg,data in
            if success == true {
                if data.count > 0 {
                    self.challengeTableData.removeAll()
                    self.setChallengesData(data: data)
                    self.tableView.reloadData()
                } else {
                   self.showAlertMessage(title: "No Result Found", message: nil)
                }
            } else {
                self.showAlertMessage(title: msg, message: nil)
                
            }
        })
    }
    
    
    func setChallengesData(data: JSON) {
        challengeData.removeAll()
        tagChallengesMapping.removeAll()
        
        for (_,item) in data {
            let challenge = Challenge()
            challenge.id = item["id"].stringValue
            challenge.title = item["title"].stringValue
            challenge.description = item["description"].stringValue
            challenge.participants_count = item["participants_count"].stringValue
            challenge.id = item["id"].stringValue
            challenge.is_scoring_in_time = item["is_scoring_in_time"].boolValue
            challenge.score_unit = item["score_unit"].stringValue
            challenge.tags = item["tags"].stringValue
            challenge.the_more_the_better = item["the_more_the_better"].boolValue
            let img = item["photo"].stringValue
            do{
                let urL = URL(string:img)
                let data = try Data(contentsOf: urL!)
                challenge.photo = data
            }catch let Error {
                print("Error:\(Error.localizedDescription)")
            }
            
            let tags = challenge.tags?.components(separatedBy: ",")
            for tag in tags ?? [] {
                if tagChallengesMapping[tag] == nil {
                    tagChallengesMapping[tag] = [item["id"].intValue]
                } else {
                    tagChallengesMapping[tag]!.append(item["id"].intValue)
                }
            }
            
            challengeData[item["id"].intValue] = challenge
            self.challengeTableData.append(challenge)
        }
        
        
        setChallengesTags()
    }
    
    //MARK: get the all list of ChallengesTags
    func setChallengesTags() {
        self.challengTagData.removeAll()
        for (tag,_) in tagChallengesMapping {
            let challengeTags = ChallengeTags()
            challengeTags.label = tag
            self.challengTagData.append(challengeTags)
        }
        self.collectionView.reloadData()
    }
    
    //MARK: get the all list of ChallengesSearch
    func getChallengeSearch(searchString:String)
    {
        self.clearCategoriesFilter()
        
        APIService.getChallengeSearch(searchString: searchString,completion: {success,msg,data in
            if success == true {
                if data.count > 0
                {
                    self.challengeTableData.removeAll()
                    self.setChallengesData(data: data)
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
    
    
    func addCategory(category: String) {
        if selectedCategories.firstIndex(of: category) == nil {
            categoriesTagListView.addTag(category)
            selectedCategories.append(category)
            
            if selectedCategories.count%3 == 0 {
                fitnessHeadViewHeight.constant = fitnessHeadViewHeight.constant + 15
            }
        }
        
        if selectedCategories.count == 1 {
            chooseCategoriesLabel.isHidden = true
        }
        
        applyCategoriesFilter()
    }
    func removeCategory(category: String) {
        if let index = selectedCategories.firstIndex(of: category) {
            if selectedCategories.count%3 == 0 {
                fitnessHeadViewHeight.constant = fitnessHeadViewHeight.constant - 15
            }
            
            categoriesTagListView.removeTag(category)
            selectedCategories.remove(at: index)
        }
        
        if selectedCategories.count == 0 {
            chooseCategoriesLabel.isHidden = false
        }
        
        applyCategoriesFilter()
    }
    
    func clearCategoriesFilter() {
        selectedCategories.removeAll()
        categoriesTagListView.removeAllTags()
    }
    
    func applyCategoriesFilter() {
        self.challengeTableData.removeAll()
        
        if selectedCategories.count == 0 {
            for (_,challenge) in challengeData {
                self.challengeTableData.append(challenge)
            }
        } else {
            let ids = selectedCategoriesChallengesIds()
            for id in ids {
                if challengeData[id] != nil {
                    self.challengeTableData.append(challengeData[id]!)
                }
            }
        }
        
        tableView.reloadData()
    }
    
    func selectedCategoriesChallengesIds()->[Int] {
        let count = selectedCategories.count
        if count > 0 {
            if count == 1 {
                if tagChallengesMapping[selectedCategories[0]] != nil {
                    return tagChallengesMapping[selectedCategories[0]]!
                }
            } else {
                var idArray:[[Int]] = []
                for category in selectedCategories {
                    if tagChallengesMapping[category] != nil {
                        idArray.append(tagChallengesMapping[category]!)
                    }
                }
                
                if idArray.count > 1 {
                    var ids:[Int] = idArray[0]
                    for var index in 1...(idArray.count - 1) {
                        ids = Array(Set(ids).intersection(Set(idArray[index])))
                    }
                    return ids
                }
            }
        }
        return []
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
        vc?.theMoreTheBetter = challengeTableData[indexPath.row].the_more_the_better!
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
        //searchTextBox.text = challengTagData[indexPath.item].label
        //getChallengeSearch(searchString: challengTagData[indexPath.item].label ?? "")
        addCategory(category: challengTagData[indexPath.item].label ?? "")
    }
    
}
