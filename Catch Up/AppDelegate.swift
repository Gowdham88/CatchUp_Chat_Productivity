//
//  AppDelegate.swift
//  Catch Up
//
//  Created by CZ Ltd on 5/14/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    var deviceTokenString: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
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
        
        Messaging.messaging().isAutoInitEnabled = true
    /*
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "CutomCameraViewController")
        //GroupingViewController
        //UpdateGroupController
        //GroupDetailController
        //ProfileController
        //IndividualProfileDetailController
        //GroupDetailController
        //ChatDashboardController
        //TaskDashboardController
        //ProcessViewController
        //MainChatScreenController
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        */
       
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let userDefaults = UserDefaults.standard
       
        if userDefaults.value(forKey: "appFirstTimeOpend") == nil   {

            userDefaults.setValue(true, forKey: "appFirstTimeOpend")
            
           if Auth.auth().currentUser?.uid != nil {
            
            do {
                
                try Auth.auth().signOut()
                
            }catch {
                
            }
                
            }
           
            moveToSignIn()
            
        } else {
            
            if Auth.auth().currentUser?.uid != nil {
                
                moveToDashboard()
                
            }else {
                
                moveToSignIn()
            }
            
           
        }
        
//        if Auth.auth().currentUser != nil {
//
        // let storyboard = UIStoryboard(name: "Auth", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginWithNumberController")
//        self.window?.rootViewController = initialViewController
//        self.window?.makeKeyAndVisible()
//        }else {
//
//        //    let storyboard = UIStoryboard(name: "Chat", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ChatDashboardController")
//        self.window?.rootViewController = initialViewController
//        self.window?.makeKeyAndVisible()
//        }
        
        
        
        return true
    }
    
    func moveToSignIn() {
        
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        
        let destinationController = storyboard.instantiateViewController(withIdentifier: "LoginWithNumberController") as? LoginWithNumberController
        
        let frontNavigationController = UINavigationController(rootViewController: destinationController!)
        
        destinationController?.getDeviceToken = deviceTokenString
        
        self.window!.rootViewController = frontNavigationController
        
        frontNavigationController.navigationBar.isHidden = true
        
        self.window?.makeKeyAndVisible()
    }
    
    func moveToDashboard() {
        
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        
        let destinationController = storyboard.instantiateViewController(withIdentifier: "ChatDashboardController") as? ChatDashboardController
        
        let frontNavigationController = UINavigationController(rootViewController: destinationController!)
        
        destinationController?.getDeviceToken = deviceTokenString
        
        self.window!.rootViewController = frontNavigationController
        
        frontNavigationController.navigationBar.isHidden = true
        
        self.window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
//        Messaging.messaging().apnsToken = deviceToken
         deviceTokenString = deviceToken.hexString
        
        print("printing device token",deviceTokenString!)
    }
}

extension AppDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
//                self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
            }
        }
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

extension AppDelegate {
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

@available(iOS 10, *)
extension AppDelegate  {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print("will present notification full message",userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID in response: \(messageID)")
        }
        
        // Print full message.
        print("response full message",userInfo)
        
        completionHandler()
    }
}


extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
