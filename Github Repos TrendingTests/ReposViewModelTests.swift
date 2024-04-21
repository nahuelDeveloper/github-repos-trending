//
//  ReposViewModelTests.swift
//  Github Repos TrendingTests
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import XCTest

final class ReposViewModelTests: XCTestCase {
    private var sut: ReposViewModel!

    override func setUp() {
        let service = MockReposService()
        sut = ReposViewModel(reposService: service)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testReposAreLoadedSuccesfully() {
        let expectation = XCTestExpectation(description: "Repos loaded")
        
        sut.$repos
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &sut.cancellables)
        sut.loadRepos()
        wait(for: [expectation], timeout: 5)
        
        XCTAssertEqual(sut.repos.count, 3)
    }
}
