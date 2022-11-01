//
//  AppDelegate.swift
//  ExpenseIncomeTracker
//
//  Created by Sayujya Singh on 25/10/2022.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let nav = UINavigationController(rootViewController: ViewController())
                window?.rootViewController = nav
                window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
                         
        IQKeyboardManager.shared.enable = true
        
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true
        
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
          
//          ApplicationDelegate.shared.application(
//              application,
//              open: url,
//              sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//              annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//          )
    }

}

