//
//  PexelPaginatorTests.swift
//  PexelSDKTests
//
//  Created by Ilia Baudin on 01.08.2024.
//

import XCTest
@testable import PexelSDK

final class PexelPaginatorTests: XCTestCase {
    
    // MARK: - Private properties
    private let amountPerPage: Int = 10
    private var paginator: PexelPaginator!

    // MARK: - XCTestCase
    override func setUpWithError() throws {
        paginator = PexelPaginator(perPage: amountPerPage)
    }
    
    // MARK: - Tests
    /// Check paginator increment logic
    /// - Expected: After each increment page should be increased by 1 and when all data loaded values should be reverted back to initial
    func testPaginatorIncrement() throws {
        XCTAssertFalse(paginator.allDataLoaded)
        XCTAssertEqual(paginator.page, 1)
        XCTAssertEqual(paginator.perPage, amountPerPage)
        paginator.increment()
        XCTAssertFalse(paginator.allDataLoaded)
        XCTAssertEqual(paginator.page, 2)
        paginator.increment()
        XCTAssertFalse(paginator.allDataLoaded)
        XCTAssertEqual(paginator.page, 3)
        paginator.increment(loadingFinished: true)
        XCTAssert(paginator.allDataLoaded)
        XCTAssertEqual(paginator.page, 3)
    }
    
    /// Check paginator reset logic
    /// - Expected: After each increment page should be increased by 1 and when reset method called values should be reverted to initial
    func testPaginatorReset() throws {
        XCTAssertFalse(paginator.allDataLoaded)
        XCTAssertEqual(paginator.page, 1)
        XCTAssertEqual(paginator.perPage, amountPerPage)
        paginator.increment()
        XCTAssertFalse(paginator.allDataLoaded)
        XCTAssertEqual(paginator.page, 2)
        paginator.resetPagination()
        XCTAssertFalse(paginator.allDataLoaded)
        XCTAssertEqual(paginator.page, 1)
    }

}
