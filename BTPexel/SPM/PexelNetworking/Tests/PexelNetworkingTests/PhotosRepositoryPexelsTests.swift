//
//  PhotosRepositoryPexelsTests.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 22.09.2025.
//

import XCTest
@testable import PexelNetworking
@testable import PexelDomain

final class PhotosRepositoryPexelsTests: XCTestCase {
    
    // MARK: - Tests
    func testFetchCuratedReturnsMappedDomainPhotos() async throws {
        let client = MockHTTPClient(data: TestJSON.curatedOk2Photos, status: 200)
        let repository = PhotosRepositoryPexels(client: client)
        
        let photos = try await repository.fetchCurated(page: 1, perPage: 30)
        XCTAssertEqual(photos.count, 2)
        XCTAssertEqual(photos[0].authorName, "Alice")
        XCTAssertEqual(photos[1].id, "1002.5")
    }
    
    func testFetchCuratedReturnsEmptyArray() async throws {
        let client = MockHTTPClient(data: TestJSON.curatedEmpty, status: 200)
        let repository = PhotosRepositoryPexels(client: client)
        
        let photos = try await repository.fetchCurated(page: 1, perPage: 30)
        XCTAssertTrue(photos.isEmpty)
    }
    
    func testFetchCuratedThrowsError() async throws {
        let client = MockHTTPClient(error: HTTPError.invalidURL)
        let repository = PhotosRepositoryPexels(client: client)
        
        do {
            let _ = try await repository.fetchCurated(page: 1, perPage: 30)
            XCTFail("Expected error")
        } catch HTTPError.invalidURL {
            // ok
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}

