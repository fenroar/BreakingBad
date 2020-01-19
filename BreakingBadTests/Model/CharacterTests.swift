//
//  CharacterTest.swift
//  BreakingBadTests
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import XCTest

@testable import BreakingBad

class CharacterTest: XCTestCase {

    private var jsonData: Data? {
        let bundle = Bundle(for: type(of: self))

        guard let jsonFilePath = bundle.path(forResource: "characters", ofType: "json") else {
            return .none
        }

        return try? Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
    }

    func testDecodingJSON() {
        // Load JSON and assert expected number of characters present in JSON
        guard let data = jsonData else {
            XCTFail("Local JSON could not be accesssed")
            return
        }

        let decoder = JSONDecoder()
        let characters = try! decoder.decode([Character].self, from: data)

        XCTAssertEqual(characters.count, 63)
    }

    func testFirstCharacterProperties() {
        // Load JSON and assert expected number of characters present in JSON
        guard let data = jsonData else {
            XCTFail("Local JSON could not be accesssed")
            return
        }

        let decoder = JSONDecoder()
        let characters = try! decoder.decode([Character].self, from: data)

        guard let firstCharacter = characters.first else {
            XCTFail("Could not access first and last characters in JSON response")
            return
        }

        XCTAssertEqual(firstCharacter.id, 1)
        XCTAssertEqual(firstCharacter.name, "Walter White")
        XCTAssertEqual(firstCharacter.birthday, "09-07-1958")
        XCTAssertEqual(firstCharacter.occupation, ["High School Chemistry Teacher", "Meth King Pin"])
        XCTAssertEqual(firstCharacter.img, "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")
        XCTAssertEqual(firstCharacter.status, "Presumed dead")
        XCTAssertEqual(firstCharacter.nickname, "Heisenberg")
        XCTAssertEqual(firstCharacter.appearance, [1, 2, 3, 4, 5])
        XCTAssertEqual(firstCharacter.portrayed, "Bryan Cranston")
        XCTAssertEqual(firstCharacter.category, "Breaking Bad")
        XCTAssertEqual(firstCharacter.betterCallSaulAppearance, [])
    }

    func testLastCharacterProperties() {
        // Load JSON and assert expected number of characters present in JSON
        guard let data = jsonData else {
            XCTFail("Local JSON could not be accesssed")
            return
        }

        let decoder = JSONDecoder()
        let characters = try! decoder.decode([Character].self, from: data)

        guard let lastCharacter = characters.last else {
            XCTFail("Could not access first and last characters in JSON response")
            return
        }

        XCTAssertEqual(lastCharacter.id, 117)
        XCTAssertEqual(lastCharacter.name, "Stacey Ehrmantraut")
        XCTAssertEqual(lastCharacter.birthday, "Unknown")
        XCTAssertEqual(lastCharacter.occupation, ["Mother"])
        XCTAssertEqual(lastCharacter.img, "https://vignette.wikia.nocookie.net/breakingbad/images/b/b3/StaceyEhrmantraut.png/revision/latest?cb=20150310150049")
        XCTAssertEqual(lastCharacter.status, "?")
        XCTAssertEqual(lastCharacter.nickname, "Stacey")
        XCTAssertEqual(lastCharacter.appearance, [])
        XCTAssertEqual(lastCharacter.portrayed, "Kerry Condon")
        XCTAssertEqual(lastCharacter.category, "Better Call Saul")
        XCTAssertEqual(lastCharacter.betterCallSaulAppearance, [1, 2, 3, 4])
    }
}
