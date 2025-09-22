//
//  PexelServiceTests.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 09.09.2025.
//

import Testing

@testable import PexelDomain
import Foundation

struct PexelServiceTests {

    // MARK: - Tests
    @Test("TestInitialItemsLoad")
    func testInitialLoadItems() async throws {
        let repository = MockPexelServicePhotosRepository()
        repository.resultsByPage = [
            1: .success([PexelPhoto.makePhoto(id: 1), PexelPhoto.makePhoto(id: 2)])
        ]
        let service = PexelService(perPage: 30, repository: repository)

        await service.getPhotos(isInitialLoad: true)

        let items = await service.photos
        let error = await service.dataLoadingError
        #expect(items.map(\.id) == ["1", "2"])
        #expect(error == nil)
        #expect(repository.calls.first?.0 == 1)
    }

    @Test("LoadMoreItemsUntilEndWillBeReached")
    func testLoadMoreItemsUntilEndReached() async throws {
        let repository = MockPexelServicePhotosRepository()
        repository.resultsByPage = [
            1: .success([PexelPhoto.makePhoto(id: 1), PexelPhoto.makePhoto(id: 2)]),
            2: .success([PexelPhoto.makePhoto(id: 3)]),
            3: .success([]),
        ]

        let service = PexelService(perPage: 30, repository: repository)

        await service.getPhotos(isInitialLoad: true)  // p1
        await service.getPhotos(isInitialLoad: false)  // p2
        await service.getPhotos(isInitialLoad: false)  // p3 -> empty -> stop
        await service.getPhotos(isInitialLoad: false)  // stopped

        let items = await service.photos

        #expect(items.map(\.id) == ["1", "2", "3"])
        #expect(repository.calls.map(\.0) == [1, 2, 3])
    }

    @Test("TestErrorLoading")
    func testErrorLoading() async throws {
        let repository = MockPexelServicePhotosRepository()
        repository.resultsByPage = [
            1: .failure(DomainError.underlying(NSError(domain: "", code: 500)))
        ]
        let service = PexelService(perPage: 30, repository: repository)

        await service.getPhotos(isInitialLoad: true)

        let items = await service.photos
        let error = await service.dataLoadingError

        #expect(items.isEmpty)
        #expect(error != nil)
    }

    @Test("TestReloadItemsAfterReset")
    func testReloadItemsAfterReset() async throws {
        let repository = MockPexelServicePhotosRepository()
        repository.resultsByPage = [
            1: .success([PexelPhoto.makePhoto(id: 1)]),
            2: .failure(DomainError.underlying(NSError(domain: "", code: 500))),
            3: .success([PexelPhoto.makePhoto(id: 2), PexelPhoto.makePhoto(id: 3)]),
        ]
        
        let service = PexelService(perPage: 30, repository: repository)
        
        await service.getPhotos(isInitialLoad: true) // p1 -> [1]
        await service.getPhotos(isInitialLoad: false) // p2 -> error
        
        var items = await service.photos
        var error = await service.dataLoadingError
        
        #expect(items.map(\.id) == ["1"])
        #expect(error != nil)
        
        await service.getPhotos(isInitialLoad: true) // reset + p3 -> [2,3]
        
        items = await service.photos
        error = await service.dataLoadingError
        
        #expect(items.map(\.id) == ["1"])
        #expect(error == nil)
    }
    
    @Test("TestPhotoSelection")
    func testPhotoSelection() async throws {
        let repository = MockPexelServicePhotosRepository()
        repository.resultsByPage = [
            1: .success([PexelPhoto.makePhoto(id: 1)]),
        ]
        
        let service = PexelService(perPage: 30, repository: repository)
        await service.getPhotos(isInitialLoad: true)
        
        let firstItem = await service.photos.first!
        
        await service.selectPhoto(firstItem)
        
        let selectedPhoto = await service.selectedPhoto
        #expect(selectedPhoto?.id == "1")
        
        await service.clearPhoto()
        let cleared = await service.selectedPhoto
        #expect(cleared == nil)
    }

}
