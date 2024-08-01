//
//  HttpEndpoint.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 26.07.2024.
//

struct HttpEndpoint {
    
    // MARK: - Private properties
    /// Basic endpoint domain
    private let domain: String
    
    /// Basic endpoint API domain
    private var apiEndpoint: String {
        "api.\(domain)/"
    }
    
    // MARK: - Public properties
    /// Full basic endpoint path that should be used during building requests
    public var httpEndpoint: String {
        "https://\(apiEndpoint)v1/"
    }
    
    // MARK: - Init
    /// Create `HttpEndpoint` by providing basic domain `String`
    ///
    /// - Example: pexel.com
    ///
    /// - Parameter domain: basic domain
    init(domain: String) {
        self.domain = domain
    }
}
