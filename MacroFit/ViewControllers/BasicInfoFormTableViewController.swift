//
//  BasicInfoFormTableViewController.swift
//  MacroFit
//
//  Created by Chandresh Singh on 18/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class BasicInfoFormTableViewController: UITableViewController {

    @IBOutlet weak var fitnessGoalsView: UIView!
    var goals = ["Low fat", "Build muscle", "Improve Performance"]
    var selectedGoal = String()
    
    @IBOutlet weak var activityLevelSlider: UISlider!
    @IBOutlet weak var fitnessGoalNoteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareView() {
        addFitnessGoalOptionsInView()
        
        for state: UIControlState in [.normal, .selected, .application, .reserved, .focused] {
            activityLevelSlider.setThumbImage(UIImage(named: "slider_thumb"), for: state)
        }
        
        fitnessGoalNoteTextView.layer.borderColor = UIColor.lightGray.cgColor;
        fitnessGoalNoteTextView.layer.borderWidth = 1.0;
        fitnessGoalNoteTextView.layer.cornerRadius = 15.0;
    }
    
    private func addFitnessGoalOptionsInView() {
        var y_position = 0
        for (index, goal) in goals.enumerated() {
            let button = UIButton(frame: CGRect(x: 0, y: y_position, width: Int(fitnessGoalsView.frame.width) , height: 35))
            button.backgroundColor = .white
            button.cornerRadius = 15
            button.borderWidth = 1
            button.borderColor = UIColor.lightGray
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.setTitle(goal, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.contentHorizontalAlignment = .left
            button.titleEdgeInsets = UIEdgeInsets()
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            button.addTarget(self, action: #selector(self.selectFitnessGoal(_:)), for: UIControlEvents.touchUpInside)
            button.tag = index + 1
            
            fitnessGoalsView.addSubview(button)
            
            y_position = y_position + 42
        }
    }
    
    @objc func selectFitnessGoal(_ sender: UIButton) {
        for (index, _) in goals.enumerated() {
            if let button = self.view.viewWithTag(index + 1) as? UIButton {
                button.backgroundColor = .white
                button.setTitleColor(UIColor.lightGray, for: .normal)
            }
        }
        
        sender.backgroundColor = UIColor(red: 255/255, green: 200/255, blue: 187/255, alpha: 1.0)
        sender.setTitleColor(UIColor(red: 255/255, green: 59/255, blue: 0.0, alpha: 1.0), for: .normal)
        selectedGoal = sender.currentTitle!
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
