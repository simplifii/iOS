//
//  CourseViewController.swift
//  MacroFit
//
//  Created by Sachin Arora on 15/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit

class CourseViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var yogaName = ["Yoga for beginners","Breathing exercises","Yoga for flexibility","Breathing exercises","Yoga for flexibility"]
    var yogaImage = ["yoga1","yoga2","yoga3","yoga2","yoga3"]
    var yogaPrice = ["$12.00","$29.99","$9.90","$29.99","$9.90"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackpriviousScreen(_ sender: UIButton) {
        showPreviousScreen()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yogaName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YogaCoursesTableViewCell", for: indexPath) as! YogaCoursesTableViewCell
        cell.YogaExcersiseimage.image = UIImage(named: yogaImage[indexPath.row])
        cell.YogatagName.text = yogaName[indexPath.row]
        cell.CoursePrice.text = yogaPrice[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clickdone")
        let storyBoard:UIStoryboard = UIStoryboard(name: "Course", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "YogaCourseOneViewController") as! YogaCourseOneViewController
        self.present(nextVC, animated: true, completion: nil)
    }
    
}
