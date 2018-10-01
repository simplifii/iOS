//
//  AddressFormTableViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 01/10/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddressFormTableViewController: UITableViewController, UITextViewDelegate {
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressLineTwoTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var entryNotesTextView: UITextView!
    
    
    var address:Dictionary = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prefillAddress()

        entryNotesTextView.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func prefillAddress() {
        if address["address_line_1"] != nil {
            addressTextField.text = address["address_line_1"]
        }
        if address["address_line_2"] != nil {
            addressLineTwoTextField.text = address["address_line_2"]
        }
        if address["zipcode"] != nil {
            zipcodeTextField.text = address["zipcode"]
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Entry notes"
        }
    }

}
