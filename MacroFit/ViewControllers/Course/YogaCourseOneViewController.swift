//
//  YogaCourseOneViewController.swift
//  MacroFit
//
//  Created by Sachin Arora on 15/11/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//
import UIKit
import AVKit


class YogaCourseOneViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var Seeless: UILabel!
    var isShowless = false
    var userName = ["Alex Rossi","Mary Hollinss"]
    var userImage = ["yoga1","yoga2"]
    var userComment = ["Geate Course!","Really good app. Gives you a verity of different work outs each time."]
    
    @IBOutlet weak var downarrow: UIImageView!
    @IBOutlet weak var uparrow: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewoutlet: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var playerController = AVPlayerViewController()
    var player:AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        let videoString:String? = Bundle.main.path(forResource: "Viode1", ofType: ".mp4")
        if let url = videoString
        {
            let videoURL = NSURL(fileURLWithPath: url)
            self.player = AVPlayer(url: videoURL as URL)
            self.playerController.player = self.player
        }
        
        
        
        //tap gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    
    @IBAction func reloadtable(_ sender: Any) {
        if isShowless == true{
        userComment = ["Geate Course!","Really good app. Gives you a verity of different work outs each time.","Geate Course!","Geate Course!"]
        userName = ["Alex Rossi","Mary Hollinss","Mary Hollinss","Mary Hollinss"]
       userImage = ["yoga1","yoga2","yoga1","yoga2"]
            isShowless = false
             Seeless.text = "See less reviews"
            downarrow.isHidden = true
            uparrow.isHidden = false
        tableView.reloadData()
        }
        else
        {
             isShowless = true
            userName = ["Alex Rossi","Mary Hollinss"]
            userImage = ["yoga1","yoga2"]
            userComment = ["Geate Course!","Really good app. Gives you a verity of different work outs each time."]
           
             Seeless.text = "See more reviews"
            downarrow.isHidden = false
            uparrow.isHidden = true
               tableView.reloadData()
        }
    }
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YogaCourseOneTableViewCell", for: indexPath) as! YogaCourseOneTableViewCell
        cell.separatorInset = UIEdgeInsets.zero;
        cell.layoutMargins = UIEdgeInsets.zero;
        cell.preservesSuperviewLayoutMargins = false;
        cell.UserProfileimg.image = UIImage(named: userImage[indexPath.row])
        cell.userName.text = userName[indexPath.row]
        cell.userComment.text = userComment[indexPath.row]
        cell.userComment.numberOfLines = 0
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.present(self.playerController, animated: false, completion: {self.playerController.player?.play()})
    }
}
