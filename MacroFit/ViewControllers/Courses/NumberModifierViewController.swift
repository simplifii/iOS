//
//  NumberModifierViewController.swift
//  MacroFit
//
//  Created by Jon Pierce-Ruhland on 12/9/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

extension Notification.Name {
    public static let modifierApplyPressed = Notification.Name(rawValue: "NumberModifierViewController.ApplyPressed")
}


class NumberModifierViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var applyButton: UIButton!
    
    private var didInit = false
    
    var displayTitle: String = "Weight (lb)"  { didSet { refreshIfAble() } }
    var options: [String]? { didSet { refreshIfAble() } }
    var modifierKey = ""
    var selectedIndex = 5 { didSet { refreshIfAble() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        didInit = true
        preferredContentSize = CGSize(width: 300, height: 200)
        modalPresentationStyle = .popover
        refreshIfAble()
    }
    
    func refreshIfAble() {
        if !didInit { return }
        pickerView.reloadAllComponents()
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
        titleLabel.text = displayTitle
    }

    @IBAction func applyPressed(_ sender: Any) {
        var userinfo: [String:Any] = [:]
        if let selected = options?[pickerView.selectedRow(inComponent: 0)] {
            userinfo["value"] = selected
            userinfo["index"] = pickerView.selectedRow(inComponent: 0)
            userinfo["modifierKey"] = modifierKey
        }
        NotificationCenter.default.post(name: .modifierApplyPressed, object: nil, userInfo: userinfo)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension NumberModifierViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? (options?.count ?? 0) : 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options?[row]
    }
}
