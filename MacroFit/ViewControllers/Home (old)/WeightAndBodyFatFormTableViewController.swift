//
//  WeightAndBodyFatFormTableViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 26/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class WeightAndBodyFatFormTableViewController: UITableViewController {

    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var bodyFatTextField: UITextField!

    var weight:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weightTextField.text = weight
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

}
