//
//  SelectPhotoTests.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 12.09.2025.
//

import Testing
@testable import PexelDomain

struct SelectPhotoTests {
    
    // MARK: - Tests
    @Test("TestSelectPhoto")
    func testSelectPhoto() async throws {
        let selectUseCase = SelectPhoto()
        let photo = PexelPhoto.makePhoto(id: 1)
        
        await selectUseCase.select(photo)
        let currentSelectedPhoto = await selectUseCase.selected
        
        #expect(currentSelectedPhoto?.id == "1")
        #expect(currentSelectedPhoto?.photoTitle == "t_1")
        #expect(currentSelectedPhoto?.authorName == "a_1")
    }
    
    @Test("TestSelectAnotherPhoto")
    func testSelectAnotherPhoto() async throws {
        let selectUseCase = SelectPhoto()
        await selectUseCase.select(PexelPhoto.makePhoto(id: 1))
        await selectUseCase.select(PexelPhoto.makePhoto(id: 2))
        
        let currentSelectedPhoto = await selectUseCase.selected
        #expect(currentSelectedPhoto?.id == "2")
        #expect(currentSelectedPhoto?.photoTitle == "t_2")
        #expect(currentSelectedPhoto?.authorName == "a_2")
    }
    
    @Test("ConcurrentSelectPhotoUsedSerializedAndUniqueApproach")
    func testConcurrentSelectPhotoUsedSerializedAndUniqueApproach() async throws {
        let selectUseCase = SelectPhoto()
        let photo1 = PexelPhoto.makePhoto(id: 1)
        let photo2 = PexelPhoto.makePhoto(id: 2)
        let photo3 = PexelPhoto.makePhoto(id: 3)
        
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await selectUseCase.select(photo1) }
            group.addTask { await selectUseCase.select(photo2) }
            group.addTask { await selectUseCase.select(photo3) }
        }
        
        let currentSelectedPhoto = await selectUseCase.selected
        #expect(currentSelectedPhoto != nil)
        #expect(["1", "2", "3"].contains(currentSelectedPhoto?.id))
    }
}
