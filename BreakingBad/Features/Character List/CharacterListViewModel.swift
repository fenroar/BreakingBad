//
//  CharacterListViewModel.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import Foundation

protocol CharacterListViewModelDelegate: class {
    func characterListLoadDidComplete()
}

final class CharacterListViewModel {

    // MARK: - Properties
    private (set) var items: [CharacterListItemViewModel] = []

    private let networkService: NetworkService
    private weak var delegate: CharacterListViewModelDelegate?

    init(networkService: NetworkService, delegate: CharacterListViewModelDelegate?) {
        self.networkService = networkService
        self.delegate = delegate
    }

    func loadCharacters() {
        networkService.getCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.items = characters.compactMap { CharacterListItemViewModel(character: $0) }

            case .failure(let error):
                // TODO: Handle error case
                break
            }

            self?.delegate?.characterListLoadDidComplete()
        }
    }
}
