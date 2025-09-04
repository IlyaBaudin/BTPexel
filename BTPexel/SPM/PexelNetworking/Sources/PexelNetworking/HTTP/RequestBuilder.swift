//
//  RequestBuilder.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 27.08.2025.
//

import Foundation

struct RequestBuilder {
    let config: PexelsConfig
    
    func makeRequest(route: PexelsRoute) throws -> URLRequest {
        guard var components = URLComponents(url: config.baseURL, resolvingAgainstBaseURL: false) else {
            throw HTTPError.invalidURL
        }
        
        components.path += route.path
        components.queryItems = route.queryItems.isEmpty ? nil : route.queryItems
        
        guard let url = components.url else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = route.method
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(config.apiKey, forHTTPHeaderField: "Authorization")
        return request
    }
}
