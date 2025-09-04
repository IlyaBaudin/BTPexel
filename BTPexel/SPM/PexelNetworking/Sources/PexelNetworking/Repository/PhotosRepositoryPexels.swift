//
//  PhotosRepositoryPexels.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 28.08.2025.
//

import Foundation
import PexelDomain

public final class PhotosRepositoryPexels: PhotosRepository, Sendable {
    
    private let client: HTTPClientProtocol
    private let mapper = PhotoMapper()
    
    public init(client: HTTPClientProtocol) {
        self.client = client
    }
    
    public func fetchCurated(page: Int, perPage: Int) async throws -> [PexelDomain.PexelPhoto] {
        let dto: CuratedResponseDTO = try await client.get(.curated(page: page, perPage: perPage))
        return mapper.map(dto.photos)
    }
    
}
