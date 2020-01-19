//
//  CharacterListViewModel.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import Foundation

protocol CharacterListViewModelDelegate: class {
    func characterListViewModelStateDidChange(_ state: CharacterListViewModel.State)
}

final class CharacterListViewModel {

    enum State: Equatable {
        case loading
        case itemsUpdated
        case failed(message: String)

        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading),
                 (.itemsUpdated, .itemsUpdated):
                return true
            case (let .failed(lhsError), let .failed(rhsError)):
                return lhsError == rhsError
            default:
                return false
            }
        }
    }

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
        delegate?.characterListViewModelStateDidChange(.loading)

        networkService.getCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.loadedCharacters = characters
                self?.delegate?.characterListViewModelStateDidChange(.itemsUpdated)
            case .failure(let error):
                self?.delegate?.characterListViewModelStateDidChange(.failed(message: error.localizedDescription))
            }

        }
    }

    func filter(_ searchTerm: String) {
        self.filterTerm = searchTerm
        delegate?.characterListViewModelStateDidChange(.itemsUpdated)
    }
}
