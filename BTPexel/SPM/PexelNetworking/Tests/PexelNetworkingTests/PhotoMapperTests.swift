//
//  PhotoMapperTests.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 22.09.2025.
//

import XCTest
@testable import PexelNetworking
@testable import PexelDomain

final class PhotoMapperTests: XCTestCase {
    
    // MARK: - Tests
    func testConvertRoundedIdPhotoDTO() throws {
        let dto = PhotoDTO(
            id: 1234.0,
            url: "u",
            photographer: "a",
            alt: "t",
            src: SrcDTO(original: "o", large2x: "l2", large: "l", medium: "m")
        )
        
        let out = PhotoMapper().map(dto)
        XCTAssertEqual(out.id, "1234")
    }
    
    func testConvertNotRoundedIdPhotoDTO() throws {
        let dto = PhotoDTO(
            id: 1234.5,
            url: "u",
            photographer: "a",
            alt: "t",
            src: SrcDTO(original: "o", large2x: "l2", large: "l", medium: "m")
        )
        
        let out = PhotoMapper().map(dto)
        XCTAssertEqual(out.id, "1234.5")
    }
}
