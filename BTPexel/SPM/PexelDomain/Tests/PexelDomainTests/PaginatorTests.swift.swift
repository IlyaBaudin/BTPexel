//
//  PaginatorTests.swift.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 05.09.2025.
//

import Testing
@testable import PexelDomain

struct PaginatorTests {

    // MARK: - Tests
    @Test("InitialNextReturnsFirstPage")
    func testInitialNextReturnsFirstPage() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let paginator = Paginator(perPage: 10)
        let page1 = await paginator.nextPageIfPossible()
        #expect(page1 == 1)
        let page2 = await paginator.nextPageIfPossible()
        #expect(page2 == 2)
    }
    
    @Test("MarkEndPreventsFurtherPaging")
    func testMarkEndPreventsFurtherPaging() async throws {
        let paginator = Paginator(perPage: 10)
        _ = await paginator.nextPageIfPossible()
        await paginator.markAsAllLoaded()
        let nextPage = await paginator.nextPageIfPossible()
        #expect(nextPage == nil)
    }
    
    @Test("CheckResetPaginator")
    func testCheckResetPaginator() async throws {
        let paginator = Paginator(perPage: 10)
        _ = await paginator.nextPageIfPossible()
        _ = await paginator.nextPageIfPossible()
        await paginator.reset()
        let nextPage = await paginator.nextPageIfPossible()
        #expect(nextPage == 1)
    }
    
    @Test("ConcurrentNextUsedSerializedAndUniqueApproach")
    func testConcurrentNextUsedSerializedAndUniqueApproach() async throws {
        let paginator = Paginator(perPage: 10)
        let count = 10
        var results = [Int]()
        results.reserveCapacity(count)
        
        await withTaskGroup(of: Int?.self) { group in
            for _ in 0..<count {
                group.addTask {
                    await paginator.nextPageIfPossible()
                }
            }
            
            for await page in group {
                if let page { results.append(page) }
            }
            
        }
        #expect(results.count == count)
        #expect(results.sorted() == Array(1...count))
    }
}
