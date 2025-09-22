//
//  DomainError.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

import Foundation

/// Main error object for errors that can happen inside package 
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
