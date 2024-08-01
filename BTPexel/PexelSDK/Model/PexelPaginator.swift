//
//  PexelPaginator.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 31.07.2024.
//

import Foundation

internal class PexelPaginator {
    
    // MARK: - Private properties
    private let defaultInitialPage: Int = 1
    
    // MARK: - Read-only properties
    public private(set) var allDataLoaded: Bool
    public private(set) var page: Int
    public private(set) var perPage: Int
    
    // MARK: - Init
    /// Init paginator with default or custom values
    /// - Parameters:
    ///   - page: start page for loading data
    ///   - perPage: amount of records per page
    init(page: Int? = nil, perPage: Int) {
        self.allDataLoaded = false
        self.page = page ?? defaultInitialPage
        self.perPage = perPage
    }
    
    /// Increment paginator OR mark that all data has been loaded
    /// - Parameter loadingFinished: flag indicates that all data has been loaded
    func increment(loadingFinished: Bool = false) {
        guard !loadingFinished else {
            allDataLoaded = true
            return
        }
        page += 1
    }
    
    /// Reset pagination to default initial values
    func resetPagination() {
        allDataLoaded = false
        page = defaultInitialPage
    }
}
