//
//  MockPexelServicePhotosRepository.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 09.09.2025.
//

import Testing
@testable import PexelDomain

final class MockPexelServicePhotosRepository: PhotosRepository, @unchecked Sendable {
    
    var calls: [(Int, Int)] = []
    var resultsByPage: [Int: Result<[PexelPhoto], Error>] = [:]
    
    
    func fetchCurated(page: Int, perPage: Int) async throws -> [PexelPhoto] {
        calls.append((page, perPage))
        if let result = resultsByPage[page] {
            switch result {
            case .success(let array):
                return array
            case .failure(let error):
                throw error
            }
        }
        return []
    }
}
