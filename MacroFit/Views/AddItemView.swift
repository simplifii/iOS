//
//  addItemView.swift
//  MacroFit
//
//  Created by Chandresh Singh on 26/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class AddItemView: UIView {
    
    @IBOutlet weak var decreaseQuantityButton: UIButton!
    @IBOutlet weak var increaseQuantityButton: UIButton!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var addItemButton: UIButton!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        viewSetup()
    }

    func viewSetup() {
        if decreaseQuantityButton != nil {
            decreaseQuantityButton.borderWidth = 1.0
            decreaseQuantityButton.borderColor = Constants.backgroundColor
        }
        
        if increaseQuantityButton != nil {
            increaseQuantityButton.borderWidth = 1.0
            increaseQuantityButton.borderColor = Constants.backgroundColor
        }
        
        if itemCountLabel != nil {
            itemCountLabel.layer.borderWidth = 1.0
            itemCountLabel.layer.borderColor = Constants.backgroundColor.cgColor
        }
        
    }
    
    @IBAction func decreaseQuantity(_ sender: UIButton) {
        let quantity = Int(itemCountLabel.text!)! - 1
        if quantity == 0 {
            addItemButton.isHidden = false
        }
        itemCountLabel.text = "\(quantity)"
    }
    
    @IBAction func increaseQuantity(_ sender: UIButton) {
        let quantity = Int(itemCountLabel.text!)! + 1
        itemCountLabel.text = "\(quantity)"
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        itemCountLabel.text = "1"
        sender.isHidden = true
    }
    
}
