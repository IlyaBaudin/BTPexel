//
//  RequestBuilderTests.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 17.09.2025.
//

import XCTest
@testable import PexelNetworking

final class RequestBuilderTests: XCTestCase {
    
    // MARK: - Tests
    func testMakeRequestBuildsCorrectURLAndHeaders() throws {
        let config = PexelsConfig(apiKey: "KEY")
        let builder = RequestBuilder(config: config)

        let request = try builder.makeRequest(route: .curated(page: 2, perPage: 50))

        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.absoluteString, "https://api.pexels.com/v1/curated?page=2&per_page=50")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Accept"), "application/json")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Authorization"), "KEY")
    }

    func testMakeRequestThrowsOnBadBaseURL() {
        let bad = PexelsConfig(baseURL: URL(string: "bad://url")!, apiKey: "KEY")
        let builder = RequestBuilder(config: bad)
        XCTAssertThrowsError(try builder.makeRequest(route: .curated(page: 1, perPage: 10))) { error in
            XCTAssertTrue(error is HTTPError)
        }
    }
}
