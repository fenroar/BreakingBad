//
//  CharacterListItemCell.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import UIKit
import Kingfisher

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

    // MARK: - Properties
    private var itemViewModel: CharacterListItemViewModel?

    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.itemViewModel = .none
    }

    // MARK: - Internal
    func setup(with viewModel: CharacterListItemViewModel) {
        self.itemViewModel = viewModel
        selectionStyle = .none
        nameLabel.text = viewModel.displayName
    }

    func willDisplay() {
        guard let url = itemViewModel?.imageURL else {
            return
        }

        iconImageView.kf.setImage(with: url)
    }

    func didEndDisplay() {
        iconImageView.kf.cancelDownloadTask()
    }

    // MARK: - Private
    private func setup() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
