//
//  StubURLProtocol.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 17.09.2025.
//

import Foundation

final class StubURLProtocol: URLProtocol {

    // MARK: - Properties
    nonisolated(unsafe) static let storage = StubStorage()
    
    // MARK: - URLProtocol
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        Self.storage.capture(request)
        
        if let e = Self.storage.error(for: request) {
            client?.urlProtocol(self, didFailWithError: e)
            return
        }
        if let (response, data) = Self.storage.response(for: request) {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
            return
        }
        client?.urlProtocol(self, didFailWithError: URLError(.badServerResponse))
    }
    
    override func stopLoading() { }
    
    // MARK: - Shared access methods
    static func setStubResponse(_ block: StubStorage.RespBlock?) {
        storage.setResponse(block)
    }
    
    static func setStubError(_ block: StubStorage.ErrBlock?) {
        storage.setError(block)
    }
    
    static func reset() {
        storage.reset()
    }
    
    static func lastRequest() -> URLRequest? {
        storage.lastRequest()
    }
}

