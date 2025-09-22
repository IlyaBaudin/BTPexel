//
//  PexelsConfig.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 27.08.2025.
//

import Foundation

public struct PexelsConfig: Sendable, Equatable {
    // MARK: - Properties
    public let baseURL: URL
    public let apiKey: String
    
    // MARK: - Init
    public init(baseURL: URL = URL(string: "https://api.pexels.com/v1/")!,
                apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
}

