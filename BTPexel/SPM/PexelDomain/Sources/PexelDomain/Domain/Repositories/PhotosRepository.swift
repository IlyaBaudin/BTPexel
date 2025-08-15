//
//  PhotosRepository.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

public protocol PhotosRepository: Sendable {
    func fetchCurated(page: Int, perPage: Int) async throws -> [PexelPhoto]
}
