//
//  PexelsConfig.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 27.08.2025.
//

import Foundation

public struct PexelsConfig: Sendable, Equatable {
    public let baseURL: URL
    public let apiKey: String
    
    public init(baseURL: URL = URL(string: "https://api.pexels.com/v1/")!,
                apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
}

