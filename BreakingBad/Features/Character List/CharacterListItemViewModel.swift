//
//  CharacterListItemViewModel.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import Foundation

final class CharacterListItemViewModel {
    // MARK: - Properties
    private let character: Character

    var displayName: String {
        return character.name
    }

    var imageURL: URL? {
        return URL(string: character.img)
    }

    // MARK: - Properties
    init(character: Character) {
        self.character = character
    }

    func detailViewModel() -> CharacterDetailViewModel {
        return CharacterDetailViewModel(character: character)
    }
}
