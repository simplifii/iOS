//
//  SubtotalTableViewCell.swift
//  MacroFit
//
//  Created by Chandresh Singh on 01/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class SubtotalTableViewCell: UITableViewCell {

    @IBOutlet weak var originalAmountLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var creditsAppliedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setSubtotal(originalSubtotal:Int, finalSubtotal: Int, credits: Int) {
        subtotalLabel.text = "$\(finalSubtotal)"
        
        if credits > 0 {
            originalAmountLabel.text = "$\(originalSubtotal)"
            originalAmountLabel.isHidden = false
            addDiagonalStrikeOnOriginalAmount()

            
            creditsAppliedLabel.text = "\(credits) credits applied"
            creditsAppliedLabel.isHidden = false
        }
    }
    
    private func addDiagonalStrikeOnOriginalAmount() {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 0, y: originalAmountLabel.frame.height - 5))
        linePath.addLine(to: CGPoint(x: originalAmountLabel.frame.width, y: 5))
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.lineWidth = 2
        lineLayer.strokeColor = Constants.schemeColor.cgColor
        originalAmountLabel.layer.addSublayer(lineLayer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
