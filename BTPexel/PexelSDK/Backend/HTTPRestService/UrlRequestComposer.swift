//
//  UrlRequestComposer.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 27.07.2024.
//

import Foundation

/// Implementation of `RequestComposerProtocol` that transform `Routable` item to `URLRequest?` object
final class UrlRequestComposer: RequestComposerProtocol {
    
    typealias RequestType = URLRequest?
    
    // MARK: - Private properties
    /// `HttpEndpoint` that contain all necessary data for construct HTTP request
    private let httpEndpoint: HttpEndpoint
    
    // MARK: - Init
    /// Create `UrlRequestComposer` object using `HttpEndpoint` object
    /// - Parameter httpEndpoint: basic `HttpEndpoint` object
    init(httpEndpoint: HttpEndpoint) {
        self.httpEndpoint = httpEndpoint
    }
    
    // MARK: - RequestComposerProtocol
    internal func compose(request: any Routable) -> URLRequest? {
        guard let basicUrl = URL(string: httpEndpoint.httpEndpoint),
              let requestUrl = URL(string: request.path, relativeTo: basicUrl) else {
            print("Error: UrlRequestComposer - can't compose correct URLRequest")
            return nil
        }
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = request.method
        urlRequest.httpBody = getHttpBody(request: request)
        return urlRequest
    }
    
    // MARK: - Private methods
    /// Transform `Routable` parameters to optional `Data` object for `URLRequest.httpBody` field
    /// - Parameter request: any `Routable` object
    /// - Returns: serialized `Data` object with provided request parameters OR nil
    private func getHttpBody(request: any Routable) -> Data? {
        guard let parameters = request.parameters else {
            return nil
        }
        do {
            return try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            print("Error: UrlRequestComposer - HttpBody serialization error: \(error)")
            return nil
        }
    }
}
