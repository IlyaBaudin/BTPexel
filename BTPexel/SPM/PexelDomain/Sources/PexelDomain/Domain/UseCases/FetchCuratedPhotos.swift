//
//  FetchCuratedPhotos.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

import Foundation

/// Use case that allow to get the list of photos (with offset and limit)
public struct FetchCuratedPhotos: Sendable {
    // MARK: - Private properties
    private let repo: PhotosRepository
    
    // MARK: - Init
    public init(repo: PhotosRepository) {
        self.repo = repo
    }
    
    // MARK: - Public methods
    public func execute(page: Int, perPage: Int) async throws -> [PexelPhoto] {
        try await repo.fetchCurated(page: page, perPage: perPage)
    }
}
