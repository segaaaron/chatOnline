//
//  AppDelegate.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 9/15/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //firebase connection
        FirebaseApp.configure()
        // persistLogin
        window = UIWindow()
        window?.makeKeyAndVisible()
        let logginVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "LoginVC")
        let navController = UINavigationController(rootViewController: logginVC)
        navController.navigationBar.barStyle = .black
        window?.rootViewController = navController
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func loginUser() -> Bool {
        let auth = Auth.auth()
        print("auth user", auth.currentUser!)
        if(auth.currentUser != nil) {
            return true
        } else {
            return false
        }
    }
    
}

