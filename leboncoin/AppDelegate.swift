//
//  AppDelegate.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 20/09/2022.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavidationBar()
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
    private func setupNavidationBar(){
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.font: AppStyle.Font.relewayExtraBol(size: 26).font,  NSAttributedString.Key.foregroundColor: AppStyle.Color.mainOrange]
        appearance.backgroundColor = AppStyle.Color.white
        UINavigationBar.appearance().standardAppearance = appearance
        if #available(iOS 15, *) {
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
}
