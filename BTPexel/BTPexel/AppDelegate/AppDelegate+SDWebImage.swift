//
//  AppDelegate+SDWebView.swift
//  BTPexel
//
//  Created by Ilia Baudin on 08.08.2025.
//

import SDWebImage

// MARK: - AppDelegate + SDWebImage
extension AppDelegate {
    internal func configureSDImageCache() {
        let cache = SDImageCache.shared
        cache.config.maxMemoryCost = 50 * 1024 * 1024
        cache.config.maxMemoryCount = 200
        
        NotificationCenter.default.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: nil,
            queue: .main
        ) { _ in
            SDImageCache.shared.clearMemory()
        }
    }
}
