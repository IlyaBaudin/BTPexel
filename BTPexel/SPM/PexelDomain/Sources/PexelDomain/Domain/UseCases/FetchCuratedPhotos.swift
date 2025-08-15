//
//  File.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

import Foundation

public struct FetchCuratedPhotos: Sendable {
    private let repo: PhotosRepository
    
    public init(repo: PhotosRepository) {
        self.repo = repo
    }
    
    public func execute(page: Int, perPage: Int) async throws -> [PexelPhoto] {
        try await repo.fetchCurated(page: page, perPage: perPage)
    }
}
