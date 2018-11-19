//
//  AppDelegate.swift
//  MacroFit
//
//  Created by Chandresh Singh on 17/09/18.
//  Copyright © 2018 Chandresh Singh. All rights reserved.
//

import UIKit
import CoreData
import Stripe
import FBSDKLoginKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        STPPaymentConfiguration.shared().publishableKey = "pk_test_MImoV6wrzv2xoUmWcbPJVBhs"

        checkUserToken()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // ####### Firebase start ######
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self as? MessagingDelegate
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // ####### Firebase end ######
        
        return true
    }
    
    func setRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as UIViewController
        
        let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationViewController") as! UINavigationController
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(mainVC, animated: false)
        navigationController.popToRootViewController(animated: false)
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func checkUserToken() {
        if let token = UserDefaults.standard.string(forKey: UserConstants.userToken) {
            if !token.isEmpty {
                setRootViewController()
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MacroFit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        print("didReceiveRemoteNotification")
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        print("didReceiveRemoteNotification and handler")
        
        if let type = userInfo["gcm.notification.type"] as? String {
            print(type)
            if type == "friends_score" || type == "friends_best_score" {
                print("************")
                
                let vc = UIStoryboard(name: "Challenges", bundle: nil).instantiateViewController(withIdentifier: "PushUpChallenge") as? PushUpChallengeViewController
                if let title = userInfo["gcm.notification.title"] as? String {
                    vc?.challengeTitle = title
                }
                if let participantsCount = userInfo["gcm.notification.participants_count"] as? String {
                    vc?.challengeParticipants_count = participantsCount
                }
                if let description = userInfo["gcm.notification.description"] as? String {
                    vc?.challengeDescription = description
                }
                if let id = userInfo["gcm.notification.id"] as? String {
                    vc?.challengeId = id
                }
                if let scoreUnit = userInfo["gcm.notification.score_unit"] as? String {
                    vc?.challengeScore_unit = scoreUnit
                }
                if let isScoringInTime = userInfo["gcm.notification.is_scoring_in_time"] as? String {
                    if isScoringInTime == "0" {
                        vc?.challengeIs_scoring_in_time = false
                    } else {
                        vc?.challengeIs_scoring_in_time = true
                    }
                }
                if let theMoreTheBetter = userInfo["gcm.notification.the_more_the_better"] as? String {
                    if theMoreTheBetter == "0" {
                        vc?.theMoreTheBetter = false
                    } else {
                        vc?.theMoreTheBetter = true
                    }
                }
                
                //                vc?.challengePhoto = data["photo"]
                
                self.navigationController?.isNavigationBarHidden = true
                self.navigationController?.pushViewController(vc!, animated: true)
                
            }
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
    }

}


extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
        if UserDefaults.standard.string(forKey: UserConstants.userCardUniqueCode) != nil {
            if fcmToken != (UserDefaults.standard.string(forKey: UserConstants.deviceToken) ?? "") {
                APIService.updateDeviceToken(token:fcmToken, completion: {success,msg in
                    print(msg)
                    if success {
                        UserDefaults.standard.set(fcmToken, forKey: UserConstants.deviceToken)
                    }
                })
            }
        } else {
            UserDefaults.standard.set(fcmToken, forKey: UserConstants.deviceToken)
        }
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
}

