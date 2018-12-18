//
//  HomeVC.swift
//  MacroFit
//
//  Created by mac on 12/14/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import SideMenu

class HomeVC: BaseVC {

    
    @IBOutlet weak var pagerContainerView: UIView!
    
    var tabs : [ViewPagerTab]!
    var list = [CoursesAndChallengesModel]()
    var viewPagerControllers = [BaseVC]()
    
    var currentViewController:BaseVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
    func initData(){
        initTabs()
        initViewPagerControllers()
        initViewPager()
    }
    
    override func viewWillLayoutSubviews() {
        self.automaticallyAdjustsScrollViewInsets = true;
    }
    
    override func isInitNavigationBar()->Bool{
        return true;
    }
    override func getNavigationbarTitle()->String{
        return "Home";
    }
    
    func initTabs(){
        tabs = [ViewPagerTab]()
        tabs.append(getViewPagerTab(index: 0))
        tabs.append(getViewPagerTab(index: 1))
        tabs.append(getViewPagerTab(index: 2))
    }
    
    func initViewPager(){
        //        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 50)
        
        //self.title = "Appointments"
        let rect = self.pagerContainerView.bounds;
        //        let h = (self.navigationController?.navigationBar.bounds.origin.y)!+(self.navigationController?.navigationBar.bounds.height)! + 20;
        let frame = CGRect.init(x: 0, y: 0, width: ScreenUtils.screenWidth, height: rect.height)
        //        print("Height : \(rect.height), H : \(h)")
        print(rect.width)
        let myOptions = ViewPagerOptions(viewPagerWithFrame: frame)
        
        // Let's show image with text
        myOptions.tabType = ViewPagerTabType.basic
        myOptions.tabViewHeight = 60;
        //        myOptions.tabType = ViewPagerTabType.imageWithText
        //        myOptions.tabViewImageSize = CGSize(width: 20, height: 20)
        myOptions.tabViewTextFont = UIFont.init(name: "Montserrat-SemiBold", size: 20)
        myOptions.tabViewTextFontDeselected = UIFont.init(name: "Montserrat-Regular", size: 20)
        myOptions.tabViewTextDefaultColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        myOptions.tabViewTextHighlightColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        
        // If I want all my tabs to be of equal width
        myOptions.fitAllTabsInView = false;
        myOptions.isEachTabEvenlyDistributed = true;
        
        // If I don't want my tab to get highlighted for page
        myOptions.isTabHighlightAvailable = true
        myOptions.tabViewPaddingLeft = 0
        myOptions.tabViewPaddingRight = 0
        
        // If I want indicator bar to show below current page tab
        myOptions.isTabIndicatorAvailable = true
        myOptions.tabIndicatorViewBackgroundColor = #colorLiteral(red: 0.9215686275, green: 0.3294117647, blue: 0.1568627451, alpha: 1)
        
        // Oh! and let's change color of tab to red
        myOptions.tabViewBackgroundDefaultColor = UIColor.clear
        myOptions.tabViewBackgroundHighlightColor = UIColor.white
        
        let viewPager = ViewPagerController()
        viewPager.options = myOptions
        viewPager.dataSource = self
        viewPager.delegate = self;
        //Now let me add this to my viewcontroller
        self.addChildViewController(viewPager)
        self.pagerContainerView.addSubview(viewPager.view)
        
        viewPager.didMove(toParentViewController: self)
    }
    
    func getViewPagerTab(index : Int)->ViewPagerTab{
        var title:String
        
        switch index{
        case 1: title = "Trainers"; break;
        case 2: title = "Local"; break;
        default: title = "Workouts"; break;
        }
        
        let tab:ViewPagerTab = ViewPagerTab.init(title: title,image: nil)
        return tab;
    }
    
    func initViewPagerControllers(){
        viewPagerControllers.append(VCUtil.getViewController(storyBoardName: "Home", identifier: "WorkoutsVC") as! BaseVC)
        viewPagerControllers.append(VCUtil.getViewController(storyBoardName: "Home", identifier: "TrainersVC") as! BaseVC)
        viewPagerControllers.append(VCUtil.getViewController(storyBoardName: "Home", identifier: "LocalVC") as! BaseVC)
    }
}

extension HomeVC: ViewPagerControllerDataSource{
    
    func numberOfPages() -> Int {
        return 3
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs;
    }
    
    func viewControllerAtPosition(position: Int) -> UIViewController {
        currentViewController = viewPagerControllers[position]
        return currentViewController;
    }
}

extension HomeVC: ViewPagerControllerDelegate {
    
    func willMoveToControllerAtIndex(index:Int) {
//        print("Will Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
//        print("Did Moved to page \(index)")
    }
}
