//
//  addItemView.swift
//  MacroFit
//
//  Created by Chandresh Singh on 26/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

@objc protocol AddItemViewDelegate {
    func itemQuantity(count: Int)
}

class AddItemView: UIView {
    
    @IBOutlet weak var decreaseQuantityButton: UIButton!
    @IBOutlet weak var increaseQuantityButton: UIButton!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var borderView: UIView!
    
    var addItemViewDelegate: AddItemViewDelegate?


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        viewSetup()
    }

    func viewSetup() {
        if borderView != nil {
            borderView.layer.cornerRadius = 8.0
            borderView.layer.borderWidth = 1.0
            borderView.layer.borderColor = Constants.buttonBorderColor.cgColor
        }
        
        if itemCountLabel != nil {
            itemCountLabel.layer.borderWidth = 1.0
            itemCountLabel.layer.borderColor = Constants.buttonBorderColor.cgColor
        }
    }
    
    @IBAction func decreaseQuantity(_ sender: UIButton) {
        let quantity = Int(itemCountLabel.text!)! - 1
        if quantity == 0 {
            addItemButton.isHidden = false
        }
        itemCountLabel.text = "\(quantity)"
        
        addItemViewDelegate?.itemQuantity(count: Int(itemCountLabel.text!)!)
    }
    
    @IBAction func increaseQuantity(_ sender: UIButton) {
        let quantity = Int(itemCountLabel.text!)! + 1
        itemCountLabel.text = "\(quantity)"
        
        addItemViewDelegate?.itemQuantity(count: Int(itemCountLabel.text!)!)
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        itemCountLabel.text = "1"
        sender.isHidden = true
        
        addItemViewDelegate?.itemQuantity(count: Int(itemCountLabel.text!)!)
    }
    
}
