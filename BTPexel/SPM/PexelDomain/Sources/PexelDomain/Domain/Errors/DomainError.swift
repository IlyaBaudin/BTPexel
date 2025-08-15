//
//  File.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

import Foundation

public enum DomainError: Error, LocalizedError {
    case endOfFeed
    case underlying(Error)
    
    public var errorDescription: String? {
        switch self {
        case .endOfFeed:
            return "No more data"
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
