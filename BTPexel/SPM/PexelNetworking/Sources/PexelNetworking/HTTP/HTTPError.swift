//
//  HTTPError.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 27.08.2025.
//

import Foundation

public enum HTTPError: Error, Sendable {
    case invalidURL
    case requestBuildFailed
    case transport(Error)
    case badStatus(Int, Data)
    case decoding(Error)
}

// MARK: - LocalizedError
extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .requestBuildFailed:
            "Request build failed"
        case .transport(let error):
            "Transport error: \(error.localizedDescription)"
        case .badStatus(let code, _):
            "Bad status: \(code)"
        case .decoding(let error):
            "Decoding failed: \(error.localizedDescription)"
        }
    }
}
