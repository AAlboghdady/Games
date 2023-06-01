//
//  AppDelegate.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 28/05/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Constants.window = window
        
        //        AppCoordinator.shared.start()
        
        return true
    }
}
