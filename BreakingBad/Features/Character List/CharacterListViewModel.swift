//
//  CharacterListViewModel.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import Foundation

protocol CharacterListViewModelDelegate: class {
    func characterListDidUpdate()
}

final class CharacterListViewModel {

    // MARK: - Properties
    private let networkService: NetworkService
    private var loadedCharacters: [Character] = []
    private var filterTerm = ""
    private weak var delegate: CharacterListViewModelDelegate?

    var items: [CharacterListItemViewModel] {
        let filteredCharacter = loadedCharacters.filter {
            return filterTerm.isEmpty ? true : $0.name.contains(filterTerm)
        }

        return filteredCharacter.compactMap { CharacterListItemViewModel(character: $0) }
    }

    // MARK: - Initializer
    init(networkService: NetworkService, delegate: CharacterListViewModelDelegate?) {
        self.networkService = networkService
        self.delegate = delegate
    }

    // MARK: - Internal
    func loadCharacters() {
        networkService.getCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.loadedCharacters = characters

            case .failure(let error):
                // TODO: Handle error case
                break
            }

            self?.delegate?.characterListDidUpdate()
        }
    }

    func filter(_ searchTerm: String) {
        self.filterTerm = searchTerm
        delegate?.characterListDidUpdate()
    }
}
