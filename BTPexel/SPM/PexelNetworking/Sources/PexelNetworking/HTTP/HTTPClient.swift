//
//  HTTPClient.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 28.08.2025.
//

import Foundation

public protocol HTTPClientProtocol: Sendable {
    func get<T: Decodable & Sendable>(_ route: PexelsRoute) async throws -> T
}

public actor HTTPClient: HTTPClientProtocol {
    private let session: URLSession
    private let builder: RequestBuilder
    private let decoder: JSONDecoder
    
    public init(config: PexelsConfig,
                session: URLSession = .shared,
                decoder: JSONDecoder = .pexels()) {
        self.session = session
        self.builder = RequestBuilder(config: config)
        self.decoder = decoder
    }
    
    public func get<T: Decodable & Sendable>(_ route: PexelsRoute) async throws -> T {
        let request = try builder.makeRequest(route: route)
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.transport(URLError(.badServerResponse))
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw HTTPError.badStatus(httpResponse.statusCode, data)
            }
            
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw HTTPError.decoding(error)
            }
        } catch {
            if let error = error as? HTTPError {
                throw error
            }
            throw HTTPError.transport(error)
        }
    }
    
}
