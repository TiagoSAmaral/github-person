//
//  AppDelegate.swift
//  github-person
//
//  Created on 23/01/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = MainScreenView()
		self.window?.makeKeyAndVisible()
        
        #if release
        print("RELEASE")
        #endif
        
        #if DEBUG
        print("DEBUB")
        #endif
        
        return true
    }
}
