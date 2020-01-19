//
//  CharacterListItemCell.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import UIKit

final class CharacterListItemCell: UITableViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: .none)
    }

    static var estimatedHeight: CGFloat {
        return 112.0
    }

    // MARK: - Outlets
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    // MARK: - Internal
    func setup(with viewModel: CharacterListItemViewModel) {
        nameLabel.text = viewModel.displayName
    }

    // MARK: - Private
    private func setup() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
