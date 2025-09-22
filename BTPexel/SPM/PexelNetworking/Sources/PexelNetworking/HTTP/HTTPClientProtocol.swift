//
//  HTTPClientProtocol.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 22.09.2025.
//

import Foundation

public protocol HTTPClientProtocol: Sendable {
    func get<T: Decodable & Sendable>(_ route: PexelsRoute) async throws -> T
}
