//
//  AppContainer.swift
//  BTPexel
//
//  Created by Ilia Baudin on 22.09.2025.
//

import SwiftUI
import PexelDomain
import PexelNetworking

final class AppContainer: ObservableObject {
    internal let service: PexelService
    
    internal init() {
        let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "PEXELS_API_KEY") as? String ?? ""
        precondition(!apiKey.isEmpty, "PEXELS_API_KEY is missing in Info.plist")
        
        let config = PexelsConfig(apiKey: apiKey)
        let session = URLSession(configuration: .default)
        let client = HTTPClient(config: config, session: session)
        
        let repository = PhotosRepositoryPexels(client: client)
        self.service = PexelService(perPage: 30, repository: repository)
    }
}

extension AppContainer {
    static func previewService() -> PexelService {
        return AppContainer().service
    }
}
