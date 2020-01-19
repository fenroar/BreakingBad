//
//  CharacterListViewController.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import UIKit

final class CharacterListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!

    // MARK: - Properties
    var viewModel: CharacterListViewModel?

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        guard let viewModel = viewModel else {
            fatalError("")
        }

        viewModel.loadCharacters()
    }

    // MARK: - Private
    private func setup() {
        title = "Breaking Bad"

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CharacterListItemCell.estimatedHeight
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(CharacterListItemCell.nib,
                           forCellReuseIdentifier: CharacterListItemCell.reuseIdentifier)

        // TODO: Set up search controller
    }
}


// MARK: - UITableViewDataSource
extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let characterItemCell = tableView.dequeueReusableCell(withIdentifier: CharacterListItemCell.reuseIdentifier, for: indexPath) as? CharacterListItemCell,
            let itemViewModel = viewModel?.items[indexPath.row] else {
            return UITableViewCell()
        }

        characterItemCell.setup(with: itemViewModel)

        return characterItemCell
    }
}

// MARK: - UITableViewDelegate
extension CharacterListViewController: UITableViewDelegate {
    // TODO:
}

// MARK: - CharacterListViewModelDelegate
extension CharacterListViewController: CharacterListViewModelDelegate {
    func characterListLoadDidComplete() {
        tableView.reloadData()
    }
}
