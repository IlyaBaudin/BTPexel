//
//  MockHTTPClient.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 22.09.2025.
//
import Foundation

@testable import PexelNetworking
@testable import PexelDomain

internal final class MockHTTPClient: HTTPClientProtocol, @unchecked Sendable {
    
    // MARK: - Properties
    let data: Data?
    let status: Int?
    let error: (any Error)?
    
    // MARK: - Init
    init(data: Data? = nil, status: Int? = nil, error: (any Error)? = nil) {
        self.data = data
        self.status = status
        self.error = error
    }
    
    // MARK: - HTTPClientProtocol
    func get<T>(_ route: PexelsRoute) async throws -> T where T : Decodable, T : Sendable {
        if let error = error {
            throw error
        }
        guard let data, let status else { throw HTTPError.transport(URLError(.badServerResponse)) }
        guard (200..<300).contains(status) else { throw HTTPError.badStatus(status, data) }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
