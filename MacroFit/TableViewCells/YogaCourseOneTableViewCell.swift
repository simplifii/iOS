//
//  YogaCourseOneTableViewCell.swift
//  MacroFit
//
//  Created by Sachin Arora on 15/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//
import UIKit

class YogaCourseOneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userComment: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var UserProfileimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        UserProfileimg.layer.borderWidth = 1
        UserProfileimg.layer.masksToBounds = true
        UserProfileimg.layer.cornerRadius = UserProfileimg.frame.height/2
        //        UserProfileimg.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
