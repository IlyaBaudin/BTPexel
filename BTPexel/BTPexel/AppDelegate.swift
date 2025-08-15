//
//  AppDelegate.swift
//  BTPexel
//
//  Created by Ilia Baudin on 26.07.2024.
//

import UIKit
import PexelSDK
import PexelDomain

var pexelSDK: LegacyPexelSDKInterface? {
    (UIApplication.shared.delegate as? AppDelegate)?.pexelSDK
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var pexelSDK: (any LegacyPexelSDKInterface)?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureSDImageCache()
                
        // === Legacy networking stack (как в PexelCoreSDK.init()) ===
        let httpEndpoint = HttpEndpoint(domain: PexelSDKConstants.pexelProductionDomain)
        let requestComposer = UrlRequestComposer(httpEndpoint: httpEndpoint)
        let networkService = HTTPRestService(requestComposer: requestComposer)
        let requestAdapter = UrlBasicAuthRequestAdapter(token: PexelSDKConstants.pexelAPIKey)
        networkService.requestAdapter = requestAdapter
        let backend = PexelBackend(networkService: networkService)
        
        
        let repo = LegacyPhotosRepository(backend: backend)
        
        
        let service = PexelService(perPage: 30, repository: repo)
        let legacyBridge = LegacyPexelSDKAdapter(service: service) // @MainActor
        
        pexelSDK = legacyBridge
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

