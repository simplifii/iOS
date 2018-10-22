//
//  DeliveryOverViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 09/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class DeliveryOverViewController: UIViewController {
    
    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var dateTimeContainerView: RoundedCornerBoxView!
    @IBOutlet weak var openingDateLabel: UILabel!
    
    var openingDate:String = ""
    var days:String = ""
    var hours:String = ""
    var minutes:String = ""
    
    var dateTimeView:DateTimeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = Constants.backgroundColor
        openingDateLabel.text = openingDate
        
        dateTimeView = Bundle.main.loadNibNamed("DateTimeView", owner: self, options: nil)?.first as? DateTimeView
        dateTimeView.frame.size = dateTimeContainerView.bounds.size
        
        dateTimeContainerView.addSubview(dateTimeView)
        dateTimeContainerView.layer.cornerRadius = 8.0
        
        dateTimeView.daysLabel.text = days
        dateTimeView.hoursLabel.text = hours
        dateTimeView.minLabel.text = minutes
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TabBarViewControllerSegue" {
            let vc = segue.destination as! TabBarViewController
            vc.showRecipeInMeals = true
        }
    }
}
