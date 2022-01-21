// swiftlint:disable all
//  AppDelegate.swift
//  unowned
//  Created by Misha Causur on 19.11.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appearance = UINavigationBar.appearance()
        appearance.backgroundColor = UIColor.init(named: "leaf")
        appearance.tintColor = .white
        appearance.barTintColor = UIColor.init(named: "leaf")
        let font = Font.setFont(.extrabold, 21)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: font]
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    
}
