//
//  AppConstants.swift
//  
//
//  Created by Nitin Bansal on 20/05/17.
//  Copyright © 2017 Nitin Bansal. All rights reserved.
//

import UIKit

struct LISTS{
    static let GENDER = ["Male","Female","Other"]
}

enum METHODS : Int {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
    case FILE_UPLOAD
}

enum TableCellType : Int {
    case DRAWER_ITEM
    case DRAWER_CHILD_ITEM
    case SELECT_FILTER
    case COURSE
    case CHALLENGE
}

enum CollectionCellType : Int {
    case HOME_CC
    case SELECT_EVENT_CC
    case SELECT_DESIGN_CC
    case SPEAKER
    case SPONSOR
    case TITLE
    case NEWS_PR
    case MEDIA
}

enum DrawerIndex : Int {
    case HOME
    case CONFERENCE
    case SPONSORS
    case NETWORKING
    case MEDIA
    case INFO
    case CONTACT_US
    case MY_PROFILE
    
    case ABOUT
    case WHY_ATTEND
    case AGENDA
    case SPEAKERS
    case YEARS_IN_REVIEW
    case HOW_TO_GET_THERE
    case WHILE_IN_DUBAI
    case FAQ
    case TERMS_AND_CONDITIONS
    
}

enum CellAction : Int {
    case LOGOUT
    case EDIT_PROFILE
    case VIEW_WISHLIST
    case EVENT_ACTION
    case ON_SELECT
    case E_SHAGUN
    case VIEW_DETAILS
    case EXPAND
}

enum TASKCODES : Int{
    case GET_COURSES_AND_CHALLENGES
    case GET_DATA
}

enum HttpResponseResult : Int{
    case SUCCESS
    case FAILURE
}
enum REQ_CODE : Int{
    case DEFAULT
}

enum RESULT_CODE : Int{
    case SUCCESS
    case FAILURE
}
enum COLORS : String{
    case PRIMARY = "#2196F4"
    case PRIMARY_DARK = "#2196F5"
    
    case SUBTITLE_COLOR = "#465783"
    case HIGHLITED_TEXTCOLOR = "#2196F3"
    case TEXT_BLUE = "#2196F6"
    case BG_LIGHT = "#eeeeee"
    case BG_LIGHT_DISABLED = "#e5e5e5"
    
    case BLACK = "#000000"
    case WHITE = "#ffffff"
    
    case BLUE_1 = "#045279"
    case BLUE_2 = "#001D2F"
    case BLUE_3 = "#387CA1"
    
    case BROWN_1 = "#977D64"
    case BROWN_2 = "#BC9A5C"
    
    case GREY_1 = "#58595D"
    
    case GREY_LIGHT_1 = "#CBCBCB"
    case GREY_LIGHT_2 = "#CCCCCC"
    case GREY_LIGHT_3 = "#999999"
    case GREY_LIGHT_4 = "#F5F5F5"
    
    case ERROR_RED = "#E7024E"
}

struct FONT_SIZE{
    static let HEADING : CGFloat = 28.0
    static let SUBHEADING : CGFloat = 24.0
    static let MEDIUM : CGFloat = 18.0
    static let SMALL : CGFloat = 16.0
    static let TINY : CGFloat = 12.0
    static let NANO : CGFloat = 10.0
}


struct TEXT_TYPE{
    static let HEADING = "heading"
    static let SUBHEADING = "subheading"
    static let MEDIUM = "medium"
    static let SMALL = "small"
    static let TINY = "tiny"
    static let NANO = "nano"
}

struct TEXT_STYLE{
    static let BOLD = "GuessSans-Black"
    static let SEMI_BOLD = "Campton-Heavy"
    static let NORMAL = "Campton-Medium"
    static let ITALIC = "Campton-Thin-Italic"
    static let THIN = "Campton-Extra-Light"
}

struct STRINGS{
    static let EMPTY_SUBJECT = "Subject can not be empty";
    static let EMPTY_DESCRIPTION = "Description can not be empty";
    static let EMPTY_APPOINTMENT_DATE = "Please select an appointment date"
    static let EMPTY_START_TIME = "Please select start time of appointment"
    static let EMPTY_END_TIME = "Please select end time of appointment"
    static let INVALID_START_TIME = "Start time should be atleast one hour greater than current time\nStart time should be between selected slot range"
    static let INVALID_END_TIME = "End time should be between selected slot range"
}

struct AppColors{
    static let PRIMARY = "#2615a8";
    static let PRIMARY_DARK = "#101017";
    static let BLACK = "#000000";
    static let NAV_TITLE = "#ffffff";
    static let TINT_COLOR = "#ffffff";
}

struct PARAMS {
    static let  charList: [Character] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    static let numberList : [String] = ["317", "529", "612", "733", "320", "245", "561", "863", "963", "518", "213", "417", "622", "825", "972", "711", "525", "792", "435", "248", "297", "475", "562", "640", "731", "786", "511", "352", "753", "354", "225", "546", "677", "798", "998", "713"];
    static let SECURITY_KEY = "SOLSoftwarePrivateLimited";
    static let SERIAL_NO = "0005017146";
    static let TOKEN = "5unvdSlNzmKSf79oq0wjK1i79gYWNoVr5EWMPGLvDSAS7gzoalHuueMc2+DmpX2yRok/jEveyMQ=";
}

protocol RestDelegate: NSObjectProtocol {
    func onSuccess(_ object: HttpResponse, forTaskCode taskcode: TASKCODES, httpRequestObject httpRequest: HttpObject) -> Bool
    func onFailure(_ paramObject: HttpResponse, forTaskCode taskCode: TASKCODES)
    func onPreExecute(httpRequestObject: HttpObject, forTaskCode taskcode: TASKCODES)
}

protocol DrawerItemClickListener{
    func onDrawerItemClicked(index : DrawerIndex)
//    func openVC(_ identifier: VCIdentifiers?, _ index: DrawerIndex)
}
protocol VCCallback{
    func onVCResult(_ data : [String : Any]?, reqCode : REQ_CODE, resCode : RESULT_CODE)
}

protocol ActionItemClickListener{
    func onActionItemClicked(_ data : IFilter, taskCode : Int)
}
protocol DrawerDelegateMenu {
    func changeDrawerState(isOpen : Bool)
    func toggleDrawerState()
}
protocol ToolBarClickListener {
    func onHomeClicked()
    func onNotificationClicked()
}
protocol NavigationClickListener {
    func onNextClicked()
    func onBackClicked()
}
protocol TabClickListener {
    func onTabSelected(index: Int)
}
protocol Validatable {
    func isValid() -> Bool;
    func showValidationErrors();
}
