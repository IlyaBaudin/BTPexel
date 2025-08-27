//
//  Paginator.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

import Foundation

public actor Paginator {
    // MARK: - Private properties
    private nonisolated static let initialPage: Int = 1
    
    // MARK: - Read-only properties
    public private(set) var page: Int
    public private(set) var perPage: Int
    public private(set) var isAllLoaded: Bool
    
    public init(page: Int? = nil, perPage: Int) {
        self.page = page ?? Self.initialPage
        self.perPage = perPage
        self.isAllLoaded = false
    }
    
    public func nextPageIfPossible() -> Int? {
        guard !isAllLoaded else { return nil }
        defer {
            page += 1
        }
        return page
    }
    
    public func markAsAllLoaded() {
        isAllLoaded = true
    }
    
    public func reset() {
        page = Self.initialPage
        isAllLoaded = false
    }
}
