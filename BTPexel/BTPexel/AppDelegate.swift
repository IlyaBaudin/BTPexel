//
//  AppDelegate.swift
//  BTPexel
//
//  Created by Ilia Baudin on 26.07.2024.
//

import UIKit
import PexelSDK

var pexelSDK: PexelCoreSDK? {
    (UIApplication.shared.delegate as? AppDelegate)?.pexelSDK
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var pexelSDK: PexelCoreSDK?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        pexelSDK = PexelCoreSDK()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

