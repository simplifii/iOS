//
//  BaseVC.swift
//
//
//  Created by Nitin Bansal on 20/05/17.
//  Copyright © 2017 Nitin Bansal. All rights reserved.
//

import UIKit
class BaseVC: UIViewController, RestDelegate, VCCallback, UINavigationBarDelegate {
    var delegate : RestDelegate!
    
    var resultCallbackDelegate : VCCallback?
    var drawerClickDelegate : DrawerItemClickListener?
    var drawerDeleagetMenu : DrawerDelegateMenu?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self;
//        activityIndicatorView.center = self.view.center
//        activityIndicatorView.isHidden = true;
//        self.view.addSubview(activityIndicatorView)
        if let nc = self.navigationController{
            nc.navigationBar.isHidden = !self.showNavigationBar();
        }else{
            print("NC is null");
        }
        self.initToolBar()
        
//        if isInitNavigationBar(){
//
//            initNavigationBar()
//        }
//        drawerDeleagetMenu?.changeDrawerState(isOpen: false)
    }
    
    func onHomeClicked() {
        print("HomeClicked")
        if self.showBackButton(){
            self.popOrDismissVC();
        }else{
            self.drawerDeleagetMenu?.toggleDrawerState();
        }
    }
    
    func initToolBar(){
//        if let tb:GreyBgToolBar = self.toolBar{
//            if(self.showBackButton()){
//                if let homeIcon = tb.customToolBar.homeButtonIcon{
//
//                    if !MOLHLanguage.isArabic(){
//                        homeIcon.setImage(UIImage(named: "ic_back"), for: .normal)
//                        homeIcon.setImage(UIImage(named: "ic_back"), for: .highlighted)
//                        homeIcon.setImage(UIImage(named: "ic_back"), for: .selected)
//                        homeIcon.setImage(UIImage(named: "ic_back"), for: .focused)
//                    }
//                    else{
//                        homeIcon.setImage(UIImage(named: "ic_next"), for: .normal)
//                        homeIcon.setImage(UIImage(named: "ic_next"), for: .highlighted)
//                        homeIcon.setImage(UIImage(named: "ic_next"), for: .selected)
//                        homeIcon.setImage(UIImage(named: "ic_next"), for: .focused)
//                    }
//
//                    homeIcon.tintColor = #colorLiteral(red: 0.5921568627, green: 0.4901960784, blue: 0.3921568627, alpha: 1)
//                }
//            }
//            tb.setToolBarDelegate(self)
//        }
    }
    
    func showBackButton()->Bool{
        return false;
    }
    
    func isInitNavigationBar()->Bool{
        return false;
    }
    
    func showNavigationBar()->Bool{
        return false;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let nc = self.navigationController{
            nc.navigationBar.isHidden = !self.showNavigationBar();
        }
    }
    
    
    
//    func initNavigationBar(){
//        setNavigationAppearance()
//        title = getNavigationbarTitle()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_menu"), style: .plain, target: self, action: #selector(showSideMenu(_:)))
//        addNavigationButtons()
//    }
    
    func setNavigationAppearance(){
        UINavigationBar.appearance().barTintColor = UIColor.init(hex: AppColors.PRIMARY_DARK)
        UINavigationBar.appearance().tintColor = UIColor.init(hex: AppColors.TINT_COLOR)
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColorNSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }
    
//    @objc func showSideMenu(_ sender: UIBarButtonItem){
//        self.drawerDeleagetMenu?.toggleDrawerState()
//    }
    
    func addNavigationButtons(){
        
    }
    
    func getNavigationbarTitle()->String{
        return "";
    }
    
    func downloadData(httpRequest: HttpObject){
        if MyReachability.isConnectedToNetwork(){
            let downloader = AlamofireManager(httpRequest: httpRequest, restDelegate: self);
            downloader.startDownload();
        }else{
            onInternetError(httpRequest.strtaskCode)
        }
    }
    
    func onInternetError(_ taskCode : TASKCODES){
        showalert(title: "", message: "You are not connected to internet")
    }
    
    // Mark: RestDelegate
    func onPreExecute(httpRequestObject: HttpObject, forTaskCode taskcode: TASKCODES) {
        print("OnPreExecute");
//        startLoader()
    }
    
    func onSuccess(_ object: HttpResponse, forTaskCode taskcode: TASKCODES, httpRequestObject httpRequest: HttpObject) -> Bool {
//        stopLoader()
//        let response = object.responseObject as! BaseResponse;
//        if response.error{
//            if response.code == "401"{
//                logOut()
//            }
//            else{
//                showalert(title: "", message: response.message, taskCode : taskcode)
//            }
//            return false;
//        }
//        return true;
        return true
    }
    
    func logOut(){
//        DefaultsUtil.logoutUser();
//        AppDelegate.getInstance().setLoginAsRootVC()
    }
    
    func onFailure(_ paramObject: HttpResponse, forTaskCode taskCode: TASKCODES) {
        print("onFailure");
        let apiResponse = paramObject.responseObject as! BaseResponse
        if let error = apiResponse.msg{
            showError(message: error)
        }
//        stopLoader()
    }
    
//    func stopLoader(){
//        activityIndicatorView.isHidden = true;
//        self.activityIndicatorView.stopAnimating()
//    }
//    func startLoader(){
//        activityIndicatorView.isHidden = false;
//        self.activityIndicatorView.startAnimating()
//    }
    
    func showalert (title: String,message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError (title: String = "Error" ,message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showalert (title: String,message : String, taskCode : TASKCODES)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            self.onOKClicked(taskCode)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func onOKClicked(_ taskCode : TASKCODES){
        
    }
    
    
    func getExpertId() -> String {
        return UserDefaults.standard.string(forKey: "expertid")!
    }
    
    func getUSerId() -> String {
        return UserDefaults.standard.string(forKey: "expertid")!
    }
    
    func getUserToken() -> String {
        return UserDefaults.standard.string(forKey: "logintoken")!
    }
    func getuserDetails(key : String) -> Any {
        return UserDefaults.standard.string(forKey: key)!
    }
    func getFilterButton()->UIBarButtonItem{
        return UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(self.onFilterIconClicked))
    }
    func getOnlineIcon()->UIBarButtonItem{
        return UIBarButtonItem(image: UIImage(named: "online"), style: .plain, target: self, action: nil)
    }
    func getOfflineIcon()->UIBarButtonItem{
        return UIBarButtonItem(image: UIImage(named: "offline"), style: .plain, target: self, action: nil)
    }
    
    @objc func onFilterIconClicked(){
        
    }
    
    func pushVC(vc : UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popToRootVC(){
        self.navigationController?.popToRootViewController( animated: true )
    }
    
//    func pushVCWithTitle(_ identifier : String, _ title : String){
//        let vc = VCUtil.getViewController(identifier: identifier) as! BaseVC
//        pushVC(vc: vc)
//        pushVCTitle(title: title)
//    }
    
    func pushVCWithtitle(_ vc : UIViewController, _ title : String){
        pushVC(vc: vc)
        pushVCTitle(title: title)
    }
    
    func pushOrPresent(vc : UIViewController){
        
        
        if let nav = self.navigationController{
            print("push")
            nav.pushViewController(vc, animated: true)
        }else{
            print("present")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func pushVCTitle(title : String){
        let customTitle = self.navigationController?.visibleViewController?.navigationItem
        customTitle?.title = title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setNavigationTitle(_ title : String){
        let customTitle = self.navigationController?.visibleViewController?.navigationItem
        customTitle?.title = title
    }
    
    func popOrDismissVC(_ data : [String:Any]?, reqCode : REQ_CODE, resCode : RESULT_CODE){
        if let navController = self.navigationController{
            navController.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil);
        }
        if let delegate = resultCallbackDelegate{
            delegate.onVCResult(data, reqCode: reqCode, resCode: resCode)
        }
    }
    
    func popOrDismissVC(){
        print("popOrDismissVC")
        if let navController = self.navigationController{
            navController.popViewController(animated: true)
            print("popViewController")
        }else{
            self.dismiss(animated: true, completion: nil);
            print("dismissVC")
        }
    }
    
    func onVCResult(_ data: [String : Any]?, reqCode: REQ_CODE, resCode: RESULT_CODE) {
    }
    
//    @objc func hideValidationErrorOnTextfieldChanged(_ textField: CustomFloatingLabelTextField){
//        textField.hideErrorMessage()
//    }
    
    func loadLocalJson<T>(type: T.Type, filename fileName: String) -> T where T:Decodable {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        fatalError("Error loading json file")
    }
}
