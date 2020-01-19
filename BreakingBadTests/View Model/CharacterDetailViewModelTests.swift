//
//  CharacterDetailViewModelTests.swift
//  BreakingBadTests
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import XCTest

@testable import BreakingBad

class CharacterDetailViewModelTests: XCTestCase {

    // MARK: - Test cases
    func testProperties() {
        let mockCharacter = Character.mock(img: "http://example.com/image.png",
                                           name: "John",
                                           nickname: "Nickname",
                                           occupation: ["Job 1", "Job 2"],
                                           status: "Status",
                                           appearance: [1, 2],
                                           betterCallSaulAppearance: [2, 3])

        let viewModel = CharacterDetailViewModel(character: mockCharacter)
        XCTAssertEqual(viewModel.imageURL, URL(string: "http://example.com/image.png"))
        XCTAssertEqual(viewModel.displayName, "John")
        XCTAssertEqual(viewModel.displayNickname, "Nickname")
        XCTAssertEqual(viewModel.displayOccupation, "Job 1, Job 2")
        XCTAssertEqual(viewModel.displayStatus, "Status")
        XCTAssertEqual(viewModel.displaySeasonAppearances, "Breaking Bad Season: 1, 2\nBetter Call Saul Season: 2, 3")
    }

    func testCharacterNoRoles() {
        let mockCharacter = Character.mock(img: "http://example.com/image.png",
                                           name: "John",
                                           nickname: "Nickname",
                                           occupation: [],
                                           status: "Status",
                                           appearance: [1, 2],
                                           betterCallSaulAppearance: [2, 3])

        let viewModel = CharacterDetailViewModel(character: mockCharacter)
        XCTAssertEqual(viewModel.displayOccupation, "No Occupation")
    }

    func testCharacterSingleRole() {
        let mockCharacter = Character.mock(img: "http://example.com/image.png",
                                           name: "John",
                                           nickname: "Nickname",
                                           occupation: ["Job 1"],
                                           status: "Status",
                                           appearance: [1, 2],
                                           betterCallSaulAppearance: [2, 3])

        let viewModel = CharacterDetailViewModel(character: mockCharacter)
        XCTAssertEqual(viewModel.displayOccupation, "Job 1")
    }

    func testCharacterInBreakingBadOnly() {
        let mockCharacter = Character.mock(img: "http://example.com/image.png",
                                           name: "John",
                                           nickname: "Nickname",
                                           occupation: ["Job 1", "Job 2"],
                                           status: "Status",
                                           appearance: [1, 2],
                                           betterCallSaulAppearance: [])
        let viewModel = CharacterDetailViewModel(character: mockCharacter)
        XCTAssertEqual(viewModel.displaySeasonAppearances, "Breaking Bad Season: 1, 2")
    }

    func testCharacterInBetterCallSaulOnly() {
        let mockCharacter = Character.mock(img: "http://example.com/image.png",
                                           name: "John",
                                           nickname: "Nickname",
                                           occupation: ["Job 1", "Job 2"],
                                           status: "Status",
                                           appearance: [],
                                           betterCallSaulAppearance: [2, 3])
        let viewModel = CharacterDetailViewModel(character: mockCharacter)
        XCTAssertEqual(viewModel.displaySeasonAppearances, "Better Call Saul Season: 2, 3")
    }
}

private extension Character {
    static func mock(img: String, name: String, nickname: String, occupation: [String], status: String, appearance: [Int], betterCallSaulAppearance: [Int]) -> Character {
        return Character(id: Int.random(in: 0...100),
                         name: name,
                         birthday: "",
                         occupation: occupation,
                         img: img,
                         status: status,
                         nickname: nickname,
                         appearance: appearance,
                         portrayed: "",
                         category: "",
                         betterCallSaulAppearance: betterCallSaulAppearance)
    }
}
