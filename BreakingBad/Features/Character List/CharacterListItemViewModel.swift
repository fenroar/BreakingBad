//
//  CharacterListItemViewModel.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import Foundation

final class CharacterListItemViewModel {
    let displayName: String
    let imageURL: URL?

    init(character: Character) {
        self.displayName = character.name
        self.imageURL = URL(string: character.img)
    }
}
