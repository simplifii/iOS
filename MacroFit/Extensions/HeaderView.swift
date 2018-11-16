//
//  HeaderView.swift
//  MacroFit
//
//  Created by Sachin Arora on 15/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

protocol  HeaderDelegate {
    func calHeader(idx: Int)
}

class HeaderView: UIView {

    var secIndex: Int?
    var delegate: HeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(btn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var btn: UIButton = {
        let btn = UIButton(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height))
        btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 9.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 1.25
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowPath =
            UIBezierPath(roundedRect: self.bounds,
                         cornerRadius: self.layer.cornerRadius).cgPath
        let btnImage = UIImage(named: "downsmall")
        btn.setImage(btnImage , for: UIControlState.normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 290, 0, 0)
        
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.contentHorizontalAlignment = .left
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        btn.titleLabel?.font =  UIFont(name: "Montserrat-SemiBold" , size: 17)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(onClickHeaderView), for: .touchUpInside)
        return btn
    }()
    @objc  func onClickHeaderView()
    {
        if let idx = secIndex {
            delegate?.calHeader(idx: idx)
        }
    }

}
