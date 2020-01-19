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
    @IBOutlet var messageContainerView: UIView!
    @IBOutlet var errorMessageLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
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

        loadingIndicator.style = .large
        loadingIndicator.hidesWhenStopped = true

        // Set up tableView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CharacterListItemCell.estimatedHeight
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(CharacterListItemCell.nib,
                           forCellReuseIdentifier: CharacterListItemCell.reuseIdentifier)

        // Set up search controller
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type something here to search"
        searchController.searchResultsUpdater = self

        navigationItem.searchController = searchController
    }

    // MARK: - Action
    @IBAction func handleRetryButton() {
        viewModel?.loadCharacters()
    }
}

extension CharacterListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

        viewModel?.filter(text)
    }
}

// MARK: - UITableViewDataSource
extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let characterItemCell = cell as? CharacterListItemCell else {
            return
        }

        characterItemCell.willDisplay()
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let characterItemCell = cell as? CharacterListItemCell else {
            return
        }

        characterItemCell.didEndDisplay()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let characterItemViewModel = viewModel?.items[indexPath.row] else {
            return
        }

        let detailViewControlller = CharacterDetailViewController()
        detailViewControlller.viewModel = characterItemViewModel.detailViewModel()
        navigationController?.pushViewController(detailViewControlller, animated: true)
    }
}

// MARK: - CharacterListViewModelDelegate
extension CharacterListViewController: CharacterListViewModelDelegate {
    func characterListViewModelStateDidChange(_ state: CharacterListViewModel.State) {
        if state == .loading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }

        if case .failed(let errorMessage) = state {
            messageContainerView.isHidden = false
            errorMessageLabel.text = errorMessage
        } else {
            messageContainerView.isHidden = true
        }

        if case .itemsUpdated = state {
            tableView.reloadData()
            tableView.isHidden = false
        } else {
            tableView.isHidden = true
        }
    }
}
