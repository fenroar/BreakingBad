//
//  CharacterListViewModelTests.swift
//  BreakingBadTests
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import XCTest

@testable import BreakingBad

class CharacterListViewModelTests: XCTestCase {

    // MARK: - Private classes
    private class Delegate: CharacterListViewModelDelegate {
        let loadingExpectation: XCTestExpectation?
        let updateExpectation: XCTestExpectation?
        let failedExpectation: XCTestExpectation?

        init(loadingExpectation: XCTestExpectation? = .none,
             updateExpectation: XCTestExpectation? = .none,
             failedExpectation: XCTestExpectation? = .none) {
            self.loadingExpectation = loadingExpectation
            self.updateExpectation = updateExpectation
            self.failedExpectation = failedExpectation
        }

        func characterListViewModelStateDidChange(_ state: CharacterListViewModel.State) {
            switch state {
            case .loading:
                loadingExpectation?.fulfill()
            case .itemsUpdated:
                updateExpectation?.fulfill()
            case .failed:
                failedExpectation?.fulfill()
            }
        }
    }

    private class MockNetworkService: NetworkService {
        let result: Result<[Character], Error>

        init(result: Result<[Character], Error>) {
            self.result = result
        }

        func getCharacters(_ onComplete: @escaping ((Result<[Character], Error>) -> Void)) {
            onComplete(result)
        }
    }

    private struct MockError: Error { }

    // MARK: - Properties
    private let emptyDataSet: [Character] = []
    private let populatedDataSet: [Character] = [Character.mock(name: "Adam"),
                                                 Character.mock(name: "Bob"),
                                                 Character.mock(name: "Claire"),
                                                 Character.mock(name: "Daniel 1"),
                                                 Character.mock(name: "Daniel 2")]

    // MARK: - Test cases
    func testNetworkSuccess() {
        let loadingExpectation = expectation(description: "Loading data expectation")
        let updateExpectation = expectation(description: "Data loaded expectation")
        let delegate = Delegate(loadingExpectation: loadingExpectation, updateExpectation: updateExpectation)
        let mockService = MockNetworkService(result: .success([]))
        let viewModel = CharacterListViewModel(networkService: mockService, delegate: delegate)
        viewModel.loadCharacters()

        wait(for: [loadingExpectation, updateExpectation], timeout: 3.0, enforceOrder: true)

    }

    func testNetworkFailed() {
        let loadingExpectation = expectation(description: "Loading data expectation")
        let failedExpectation = expectation(description: "Network failed expectation")
        let delegate = Delegate(loadingExpectation: loadingExpectation, failedExpectation: failedExpectation)
        let mockService = MockNetworkService(result: .failure(MockError()))
        let viewModel = CharacterListViewModel(networkService: mockService, delegate: delegate)
        viewModel.loadCharacters()

        wait(for: [loadingExpectation, failedExpectation], timeout: 3.0, enforceOrder: true)
    }

    func testItemsUnfiltered() {
        assertItemsUnfiltered(dataSet: emptyDataSet, expectedCount: 0)
        assertItemsUnfiltered(dataSet: populatedDataSet, expectedCount: 5)
    }

    func testItemsFilteredWithSearchTerm() {
        assertItemsFilteredWithSearchTerm(dataSet: emptyDataSet, expectedCount: 0)
        assertItemsFilteredWithSearchTerm(dataSet: populatedDataSet, expectedCount: 2)
    }

    func testItemsFilteredWithSeasonToggle() {
        // TODO:
    }

    func testItemsFilteredWithSearchTermAndSeasonToggle() {
        // TODO:
    }

    // MARK: - Private
    private func assertItemsUnfiltered(dataSet: [Character], expectedCount: Int) {
        let mockService = MockNetworkService(result: .success(dataSet))
        let viewModel = CharacterListViewModel(networkService: mockService, delegate: .none)
        viewModel.loadCharacters()

        XCTAssertEqual(viewModel.items.count, expectedCount)
    }

    private func assertItemsFilteredWithSearchTerm(dataSet: [Character], expectedCount: Int) {
        let mockService = MockNetworkService(result: .success(dataSet))
        let viewModel = CharacterListViewModel(networkService: mockService, delegate: .none)
        viewModel.loadCharacters()
        viewModel.filter("Daniel")

        XCTAssertEqual(viewModel.items.count, expectedCount)
    }
}

private extension Character {
    static func mock(name: String) -> Character {
        return Character(id: Int.random(in: 0...100),
                         name: name,
                         birthday: "",
                         occupation: [],
                         img: "",
                         status: "",
                         nickname: "",
                         appearance: [],
                         portrayed: "",
                         category: "",
                         betterCallSaulAppearance: [])
    }
}
