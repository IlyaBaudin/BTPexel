//
//  PexelSDKTests.swift
//  PexelSDKTests
//
//  Created by Ilia Baudin on 26.07.2024.
//

import XCTest
@testable import PexelSDK

final class PexelBackendTests: XCTestCase {
    
    // MARK: - Private properties
    private var httpEndpoint: HttpEndpoint!
    private var requestComposer: (any RequestComposerProtocol)!
    private var networkService: HTTPRestService!
    private var backendService: PexelBackend<HTTPRestService>!

    // MARK: - XCTestCase
    override func setUpWithError() throws {
        httpEndpoint = HttpEndpoint(domain: PexelSDKConstants.pexelProductionDomain)
        requestComposer = UrlRequestComposer(httpEndpoint: httpEndpoint)
        networkService = HTTPRestService(requestComposer: requestComposer)
        let requestAdapter = UrlBasicAuthRequestAdapter(token: PexelSDKConstants.pexelAPIKey)
        networkService.requestAdapter = requestAdapter
        backendService = PexelBackend(networkService: networkService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Tests
    /// Perform loading curatedPhotos using correct request and configuration
    /// - Expected: First portion of data should successfully loaded
    func testBasicCuratedPhotosLoading() throws {
        let route = PexelAPIRouter.curatedPhotos(page: 1, perPage: 15)
        var response: Result<PexelCuratedResponse, Error>?
        let exp = expectation(description: "Loading photos")
        backendService.fetchData(request: route) { (result: Result<PexelCuratedResponse, Error>) in
            response = result
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10.0)
        let responseData = try XCTUnwrap(response?.get())
        XCTAssertFalse(responseData.photos.isEmpty, "Array is empty")
    }
    
    /// Perform loading curatedPhotos without Auth token
    /// - Expected: Backend should send logical error with status = 401
    func testBasicCuratedPhotosLoadingWithoutToken() throws {
        networkService.requestAdapter = nil
        let route = PexelAPIRouter.curatedPhotos(page: 1, perPage: 15)
        var response: Result<PexelCuratedResponse, Error>?
        let exp = expectation(description: "Loading photos")
        backendService.fetchData(request: route) { (result: Result<PexelCuratedResponse, Error>) in
            response = result
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10.0)
        print(response)
        XCTAssertThrowsError(try response?.get()) { error in
            guard let pexelError = error as? PexelError else {
                XCTFail("Error has got incorrect type, \(error)")
                return
            }
            XCTAssertEqual(pexelError.status, 401)
            XCTAssertEqual(pexelError.code, "Unauthorized")
        }
    }
}
