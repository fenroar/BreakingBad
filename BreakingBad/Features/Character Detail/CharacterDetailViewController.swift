//
//  CharacterDetailViewController.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import UIKit
import Kingfisher

final class CharacterDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var nicknameLabel: UILabel!
    @IBOutlet private var occupationLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var appearancesLabel: UILabel!

    // MARK: - Properties
    var viewModel: CharacterDetailViewModel?

// MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        bind()
    }

    override func viewDidDisappear(_ animated: Bool) {
        imageView.kf.cancelDownloadTask()
        super.viewDidDisappear(animated)
    }

    // MARK: - Private
    private func setup() {
        nameLabel.font = .preferredFont(forTextStyle: .title1)
        nicknameLabel.font = .preferredFont(forTextStyle: .title2)
        occupationLabel.font = .preferredFont(forTextStyle: .title3)
        statusLabel.font = .preferredFont(forTextStyle: .title3)
        appearancesLabel.font = .preferredFont(forTextStyle: .title3)
    }

    private func bind() {
        guard let viewModel = viewModel else {
            fatalError("CharacterDetailViewController requires viewModel to be set")
        }

        imageView.kf.setImage(with: viewModel.imageURL)
        nameLabel.text = viewModel.displayName
        nicknameLabel.text = viewModel.displayNickname
        occupationLabel.text = viewModel.displayOccupation
        statusLabel.text = viewModel.displayStatus
        appearancesLabel.text = viewModel.displaySeasonAppearances
    }
}

