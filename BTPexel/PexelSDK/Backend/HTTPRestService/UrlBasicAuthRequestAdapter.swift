//
//  UrlBasicAuthRequestAdapter.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 31.07.2024.
//

import Foundation

/// Implementation of `RequestAdapterProtocol` that transform `URLRequest` item to `URLRequest` by adding basic `Authorization` header using provided token
public final class UrlBasicAuthRequestAdapter: RequestAdapterProtocol {
    
    public typealias RequestType = URLRequest
    
    // MARK: - Private properties
    /// Authorization token for backend
    private let token: String
    
    // MARK: - Init
    /// Create adapter based on basic `Authorization` token
    /// - Parameter token: `String` token for `PexelAPI`
    public init(token: String) {
        self.token = token
    }
    
    // MARK: - RequestAdapterProtocol
    public func adapt(request: URLRequest) -> URLRequest {
        var adaptedRequest = request
        adaptedRequest.setValue(self.token, forHTTPHeaderField: "Authorization")
        return adaptedRequest
    }
}
