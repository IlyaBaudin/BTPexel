//
//  MockFetchCuratedPhotosRepository.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 22.09.2025.
//

@testable import PexelDomain

final class MockFetchCuratedPhotosRepository: PhotosRepository, @unchecked Sendable {
    var lastIncomeParams: (page: Int, perPage: Int)?
    var result: Result<[PexelPhoto], Error> = .success([])
    
    func fetchCurated(page: Int, perPage: Int) async throws -> [PexelPhoto] {
        lastIncomeParams = (page, perPage)
        switch result {
        case .success(let photos):
            return photos
        case .failure(let error):
            throw error
        }
    }
    
}
