//
//  CharacterListItemViewModelTests.swift
//  BreakingBadTests
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import XCTest

@testable import BreakingBad

class CharacterListItemViewModelTests: XCTestCase {

    // MARK: - Test cases
    func testProperties() {
        let mockCharacter = Character.mock(name: "John", img: "http://example.com/image.png")
        let viewModel = CharacterListItemViewModel(character: mockCharacter)
        XCTAssertEqual(viewModel.displayName, "John")
        XCTAssertEqual(viewModel.imageURL, URL(string: "http://example.com/image.png"))
    }
}

private extension Character {
    static func mock(name: String, img: String) -> Character {
        return Character(id: Int.random(in: 0...100),
                         name: name,
                         birthday: "",
                         occupation: [],
                         img: img,
                         status: "",
                         nickname: "",
                         appearance: [],
                         portrayed: "",
                         category: "",
                         betterCallSaulAppearance: [])
    }
}
