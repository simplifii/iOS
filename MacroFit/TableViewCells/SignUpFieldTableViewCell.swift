//
//  SignUpFieldTableViewCell.swift
//  MacroFit
//
//  Created by Chandresh on 30/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class SignUpFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        textField.backgroundColor = UIColor(red: 251/255, green: 250/255, blue: 249/255, alpha: 1.0)
    }

}
