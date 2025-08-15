//
//  AnyPhotosRepository.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 15.08.2025.
//

public struct AnyPhotosRepository: PhotosRepository, Sendable {
    private let _fetch: @Sendable (_ page: Int, _ perPage: Int) async throws -> [PexelPhoto]
    
    public init<R: PhotosRepository>(_ repo: R) {
        let f: @Sendable (Int, Int) async throws -> [PexelPhoto] = { page, perPage in
            try await repo.fetchCurated(page: page, perPage: perPage)
        }
        self._fetch = f
    }
    
    public init(fetch: @escaping @Sendable (_ page: Int, _ perPage: Int) async throws -> [PexelPhoto]) {
        self._fetch = fetch
    }
    
    public func fetchCurated(page: Int, perPage: Int) async throws -> [PexelPhoto] {
        try await _fetch(page, perPage)
    }
}
