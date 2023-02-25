//
//  GameGridCell.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import UIKit
import PTDesignSystem
import Kingfisher

final class GameGridCell: UICollectionViewCell {
    private struct Constants {
        static let interItemSpacing: CGFloat = 7
    }

    static let reuseIdentifier: String = "GameGridCellReuseIdentifier"

    var viewModel: GameGridCellViewModel? {
        didSet {
            bind(viewModel)
        }
    }

    private var nameLabel: PTLabel = {
        let label = PTLabel()
        var style: PTLabelStyle = .ptM
        label.style = style.withWeight(.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var ratingView: PTRatingView = {
        let view = PTRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var releasedLabel: PTLabel = {
        let label = PTLabel()
        var style: PTLabelStyle = .pt3XS
        label.style = style.withWeight(.light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var portrait: MediaView = {
        let imageView = MediaView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private var imageDownloadTask: DownloadTask?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageDownloadTask = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GameGridCell: ResponsiveCell {
    func loadImage() {
        imageDownloadTask = portrait.fetch(size: contentView.frame.size) { [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let value):
                guard let self = self else { return }
                self.portrait.image = value.image
                self.portrait.layoutIfNeeded()
            }
        }
    }
}

private extension GameGridCell {
    func bind(_ viewModel: GameGridCellViewModel?) {
        nameLabel.text = viewModel?.name
        ratingView.rating = viewModel?.rating
        releasedLabel.text = viewModel?.released
        portrait.media = viewModel?.media
    }

    func setupView() {
        contentView.addSubviews([
            portrait,
            nameLabel,
            ratingView,
            releasedLabel
        ])
        let guide = contentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.topAnchor.constraint(equalTo: portrait.topAnchor),
            guide.leadingAnchor.constraint(equalTo: portrait.leadingAnchor),
            guide.trailingAnchor.constraint(equalTo: portrait.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: portrait.bottomAnchor,
                                           constant: Constants.interItemSpacing),
            guide.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            guide.trailingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor),
            ratingView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            ratingView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                             constant: Constants.interItemSpacing),
            ratingView.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor),
            releasedLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            releasedLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor)
        ])
    }
}

