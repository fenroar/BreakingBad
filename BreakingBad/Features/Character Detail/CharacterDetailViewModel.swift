//
//  CharacterDetailViewModel.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import Foundation

final class CharacterDetailViewModel {
    let imageURL: URL?
    let displayName: String
    let displayNickname: String
    let displayOccupation: String
    let displayStatus: String
    let displaySeasonAppearances: String

    init(character: Character) {
        self.imageURL = URL(string: character.img)
        self.displayName = character.name
        self.displayNickname = character.nickname
        self.displayStatus = character.status

        if character.occupation.isEmpty {
            self.displayOccupation = "No Occupation"
        } else {
            self.displayOccupation = character.occupation.joined(separator: ", ")
        }

        var appearanceText: [String] = []
        if !character.appearance.isEmpty {
            appearanceText.append("Breaking Bad Season: \(character.appearance.map { "\($0)" }.joined(separator: ", "))")
        }

        if !character.betterCallSaulAppearance.isEmpty {
            appearanceText.append("Better Call Saul Season: \(character.betterCallSaulAppearance.map { "\($0)" }.joined(separator: ", "))")
        }

        self.displaySeasonAppearances = appearanceText.joined(separator: "\n")
    }
}
