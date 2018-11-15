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
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.contentHorizontalAlignment = .left
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        btn.titleLabel?.font =  UIFont(name: "Montserrat-SemiBold" , size: 16)
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
