//
//  GameDetailPage.swift
//  PlayTime
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit
import PTClient
import PTDesignSystem
import Kingfisher

final class GameDetailPage: UIViewController {
    private struct Constants {
        static let interItemSpacing: CGFloat = 7
    }

    var game: GameDetail? {
        didSet {
            bind()
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
        imageView.clipsToBounds = true
        return imageView
    }()

    private var imageDownloadTask: DownloadTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupSubviews()
    }
}

private extension GameDetailPage {
    func setupBackground() {
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.black.cgColor,
                           UIColor.black.withAlphaComponent(0.5).cgColor,
                           UIColor.greenApp.cgColor]
        view.layer.insertSublayer(gradient, at: 1)
        let tetrisEffect = UIImageView(image: UIImage(named: "tetrisPattern"))
        tetrisEffect.bounds = tetrisEffect.bounds.offsetBy(dx: .zero,
                                                           dy: 30)
        view.layer.insertSublayer(tetrisEffect.layer, at: 0)
        view.backgroundColor = .black
    }

    func bind() {
        nameLabel.text = game?.name
        ratingView.rating = game?.rating
        releasedLabel.text = game?.released
        portrait.media = game?.media
    }

    func setupSubviews() {
        view.addSubviews([
            portrait,
            nameLabel,
            ratingView,
            releasedLabel
        ])
        let guide = view.safeAreaLayoutGuide
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
            ratingView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            releasedLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            releasedLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor)
        ])
    }
}
