//
//  DeliveryOverEmbeddedViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 09/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

protocol DeliveryOverEmbeddedVCDelegate {
    func showRecipeView()
}

class DeliveryOverEmbeddedViewController: UIViewController {

    @IBOutlet weak var dateTimeContainerView: RoundedCornerBoxView!
    @IBOutlet weak var openingDateLabel: UILabel!
    
    var openingDate:String = ""
    var days:String = ""
    var hours:String = ""
    var minutes:String = ""
    
    var deliveryOverEmbeddedVCDelegate: DeliveryOverEmbeddedVCDelegate!
    
    var dateTimeView:DateTimeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = Constants.backgroundColor
        
        dateTimeView = Bundle.main.loadNibNamed("DateTimeView", owner: self, options: nil)?.first as? DateTimeView
        dateTimeView.frame.size = dateTimeContainerView.bounds.size
        
        dateTimeContainerView.addSubview(dateTimeView)
        dateTimeContainerView.layer.cornerRadius = 8.0
        
        setData()
    }
    
    func setData() {
        openingDateLabel.text = openingDate

        dateTimeView.daysLabel.text = days
        dateTimeView.hoursLabel.text = hours
        dateTimeView.minLabel.text = minutes
    }
    
    
    @IBAction func checkReceipes(_ sender: UIButton) {
        deliveryOverEmbeddedVCDelegate.showRecipeView()
    }
    
}
