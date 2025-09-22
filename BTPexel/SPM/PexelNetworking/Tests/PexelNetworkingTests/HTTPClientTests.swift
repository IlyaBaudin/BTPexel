//
//  HTTPClientTests.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 17.09.2025.
//

import XCTest
@testable import PexelNetworking

final class HTTPClientTests: XCTestCase {
    // MARK: - Properties
    private var session: URLSession!
    private var client: HTTPClient!
    
    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [StubURLProtocol.self]
        session = URLSession(configuration: config)
        client = HTTPClient(config: PexelsConfig(apiKey: "KEY"), session: session)
        StubURLProtocol.reset()
    }
    
    override func tearDown() {
        StubURLProtocol.reset()
        client = nil
        session = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testGetSuccessDecodesDto() async throws {
        StubURLProtocol.setStubResponse { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, TestJSON.curatedOk2Photos)
        }
        
        let dto: CuratedResponseDTO = try await client.get(.curated(page: 1, perPage: 30))
        XCTAssertEqual(dto.page, 1)
        XCTAssertEqual(dto.photos.count, 2)
        XCTAssertEqual(dto.photos[0].photographer, "Alice")
    }
    
    func testGetBadStatusReturnsHttpError() async throws {
        StubURLProtocol.setStubResponse { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, Data("oops".utf8))
        }
        
        do {
            let _: CuratedResponseDTO = try await client.get(.curated(page: 1, perPage: 30))
            XCTFail("Expected error")
        } catch let HTTPError.badStatus(code, data) {
            XCTAssertEqual(code, 500)
            XCTAssertEqual(String(data: data, encoding: .utf8), "oops")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetMalformedJSONReturnsDecodingError() async throws {
        StubURLProtocol.setStubResponse { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, TestJSON.malformed)
        }
        
        do {
            let _: CuratedResponseDTO = try await client.get(.curated(page: 1, perPage: 30))
            XCTFail("Expected decoding error")
        } catch let HTTPError.decoding(error) {
            XCTAssertTrue(error is DecodingError, "Expected DecodingError, got \(type(of: error))")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetTransportErrorWrappedAsHttpErrorTransport() async throws {
        StubURLProtocol.setStubError { _ in
            URLError(.timedOut)
        }
        
        do {
            let _: CuratedResponseDTO = try await client.get(.curated(page: 1, perPage: 30))
            XCTFail("Expected transport error")
        } catch let HTTPError.transport(error) {
            XCTAssertTrue(error is URLError)
            XCTAssertEqual((error as? URLError)?.code, .timedOut)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testRequestCorrectConstruction() async throws {
        StubURLProtocol.setStubResponse { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, TestJSON.curatedEmpty)
        }
        
        let _: CuratedResponseDTO = try await client.get(.curated(page: 2, perPage: 50))

        let request = StubURLProtocol.lastRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Authorization"), "KEY")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Accept"), "application/json")
        XCTAssertEqual(request?.url?.absoluteString, "https://api.pexels.com/v1/curated?page=2&per_page=50")
    }
}
