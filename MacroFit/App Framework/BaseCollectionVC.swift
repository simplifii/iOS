//
//  BaseCollectionVC.swift
//  Jugo
//
//  Created by akash savediya on 08/10/17.
//  Copyright © 2017 akash savediya. All rights reserved.
//

import UIKit

class BaseCollectionVC: BaseVC, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CellActionListner {

    var list = [ICollectionCell]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibIdentifiers()
        
    }
    
    func registerNibIdentifiers(){
        if let collectionView = getCollectionView(){
            if let nibNames = getNibNamesToRegister(){
                for nib in nibNames{
                    collectionView.register(UINib.init(nibName: nib, bundle: nil), forCellWithReuseIdentifier: nib)
                }
            }
        }
    }
    
    func getNibNamesToRegister()->[String]?{
        return nil;
    }
    
    func getCollectionView()->UICollectionView?{
        return nil;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel : ICollectionCell = list[indexPath.row]
        let nibName : String = getCellNibName(item: cellModel)
        let cell = getCellFromIdentifier(nibName, indexPath) as! BaseCVC
        cell.displayData(model: cellModel)
        cell.cellActionDelegate = self;
        cell.position = indexPath.row;
        return cell;
    }
    
    func getCellType(_ indexPath : IndexPath)->CollectionCellType{
        let cellModel : ICollectionCell = list[indexPath.row]
        return cellModel.getCellType();
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : getCellWidth(collectionView, indexPath), height : getCellHeight(collectionView, indexPath))
    }
    
    func getCellWidth(_ collectionView: UICollectionView, _ indexPath : IndexPath)->CGFloat {
        let cellModel : ICollectionCell = list[indexPath.row]
        let collectionCellSize = collectionView.frame.size.width;
        switch(cellModel.getCellType()){
        case .SPEAKER, .SPONSOR:
            return (collectionCellSize-16)/2;
        case .TITLE:
            return collectionCellSize;
        default:
            return (collectionCellSize-16)/2;
        }
    }
    
    func getCellHeight(_ collectionView: UICollectionView, _ indexPath : IndexPath)->CGFloat{
        let cellModel : ICollectionCell = list[indexPath.row]
        return self.getCellHeight(cellModel)
    }
    
    func getCellHeight(_ cellModel: ICollectionCell)->CGFloat{
        switch(cellModel.getCellType()){
        case .SPEAKER:
            return 180;
        case .SPONSOR:
            return 100;
        case .TITLE:
            return 44;
        default:
            return 130;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        onCellClicked(indexPath: indexPath)
    }
    
    
    
    func getCellFromNibName(_ nibName : String)->UICollectionViewCell{
        let cell = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as! UICollectionViewCell;
        
        return cell;
    }
    
    func getCellFromIdentifier(_ identifier: String, _ indexPath : IndexPath) -> UICollectionViewCell {
        if let collectionView = getCollectionView(){
            return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        }
        return getCellFromNibName(identifier)
    }
    
    func getCellNibName(item : ICollectionCell)->String{
        switch item.getCellType() {
        case .HOME_CC:
            return "HomeCVC"
        case .SELECT_DESIGN_CC:
            return "SelectDesignCVC"
        case .SPEAKER:
            return "SpeakerCVC"
        case .SPONSOR:
            return "SponsorCVC"
        case .TITLE:
            return "TitleCVC"
            
        default:
            return "";
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count;
    }
    
    override func viewWillLayoutSubviews() {
        if let cv = getCollectionView(){
            cv.contentInset = UIEdgeInsets.zero
            cv.scrollIndicatorInsets = UIEdgeInsets.zero;
        }
    }
    
    func onCellClicked(indexPath : IndexPath){
        
    }
    
    func onCellAction(actionType: CellAction, position: Int) {
        
    }
    
}
