//
//  DomainError+Extensions.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 22.09.2025.
//
import Foundation
@testable import PexelDomain

extension DomainError {
    static internal func makeError(code: Int) -> DomainError {
        DomainError.underlying(NSError(domain: "", code: code))
    }
}
