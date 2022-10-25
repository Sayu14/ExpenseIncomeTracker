//
//  AppDelegate.swift
//  ExpenseIncomeTracker
//
//  Created by Sayujya Singh on 25/10/2022.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore

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

}

