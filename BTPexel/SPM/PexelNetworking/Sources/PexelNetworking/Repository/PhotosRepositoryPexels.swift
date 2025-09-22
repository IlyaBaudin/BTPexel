//
//  PhotosRepositoryPexels.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 28.08.2025.
//

import Foundation
import PexelDomain

public final class PhotosRepositoryPexels: PhotosRepository, Sendable {
    
    // MARK: - Properties
    private let client: HTTPClientProtocol
    private let mapper = PhotoMapper()
    
    // MARK: - Init
    public init(client: HTTPClientProtocol) {
        self.client = client
    }
    
    // MARK: - PhotosRepository
    public func fetchCurated(page: Int, perPage: Int) async throws -> [PexelDomain.PexelPhoto] {
        let dto: CuratedResponseDTO = try await client.get(.curated(page: page, perPage: perPage))
        return mapper.map(dto.photos)
    }
}
