//
//  FetchCuratedPhotosTests.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 10.09.2025.
//

import Testing
@testable import PexelDomain
import Foundation

struct FetchCuratedPhotosTests {
    
    // MARK: - Tests
    @Test("TestFetchCuratedCallDelegatesToRepository")
    func testFetchCuratedDelegateToRepository() async throws {
        let repository = MockFetchCuratedPhotosRepository()
        repository.result = .success([
            PexelPhoto(id: "1", photoTitle: "Photo1", authorName: "Author1", photoUrl: "url1"),
            PexelPhoto(id: "2", photoTitle: "Photo2", authorName: "Author2", photoUrl: "url2"),
        ])
        let useCase = FetchCuratedPhotos(repo: repository)
        
        let resultOfCallUseCase = try await useCase.execute(page: 3, perPage: 50)
        #expect(repository.lastIncomeParams?.page == 3)
        #expect(repository.lastIncomeParams?.perPage == 50)
        #expect(resultOfCallUseCase.first?.id == "1")
    }
    
    @Test("TestFetchCuratedPropagateError")
    func testFetchCuratedPropagateError() async throws {
        let repository = MockFetchCuratedPhotosRepository()
        repository.result = .failure(DomainError.underlying(NSError(domain: "", code: 500)))
        let useCase = FetchCuratedPhotos(repo: repository)
        
        do {
            _ = try await useCase.execute(page: 1, perPage: 10)
            Issue.record("Error not propagated")
        } catch is DomainError {
            
        } catch {
            Issue.record("Uncorrect error type")
        }
    }
}
