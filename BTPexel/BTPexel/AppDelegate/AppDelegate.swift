//
//  AppDelegate.swift
//  BTPexel
//
//  Created by Ilia Baudin on 26.07.2024.
//

import UIKit
import PexelDomain
import PexelNetworking

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var pexelService: PexelService!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureSDImageCache()
        
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "PEXELS_API_KEY") as? String ?? ""
        precondition(!apiKey.isEmpty, "PEXELS_API_KEY is missing")
        
        let config = PexelsConfig(apiKey: apiKey)
        let client = HTTPClient(config: config)
        
        let repo = PhotosRepositoryPexels(client: client)
        
        pexelService = PexelService(perPage: 30, repository: repo)
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

