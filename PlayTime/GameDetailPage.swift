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
        static let belowImage: CGFloat = 10
        static let belowName: CGFloat = 27
    }

    var game: GameDetail? {
        didSet {
            bind()
        }
    }

    private var nameLabel: PTLabel = {
        let label = PTLabel()
        var style: PTLabelStyle = .ptXL
        label.style = style.withWeight(.semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var ratingTitleLabel: PTLabel = {
        let label = PTLabel()
        var style: PTLabelStyle = .ptM
        label.style = style.withWeight(.semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rating"
        return label
    }()

    private var releasedTitleLabel: PTLabel = {
        let label = PTLabel()
        var style: PTLabelStyle = .ptM
        label.style = style.withWeight(.semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Released"
        return label
    }()

    private var ratingView: PTRatingView = {
        let view = PTRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var releasedLabel: PTLabel = {
        let label = PTLabel()
        label.style = .ptXL
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var playtimeLabel: PTLabel = {
        let label = PTLabel()
        var style: PTLabelStyle = .ptM
        label.style = style.withWeight(.semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var statusTitleLabel: PTLabel = {
        let label = PTLabel()
        var style: PTLabelStyle = .ptM
        label.style = style.withWeight(.semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Play status"
        return label
    }()

    private var descriptionTitleLabel: PTLabel = {
        let label = PTLabel()
        var style: PTLabelStyle = .ptM
        label.style = style.withWeight(.semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        return label
    }()

    private var descriptionBodyLabel: PTLabel = {
        let label = PTLabel()
        var style: PTLabelStyle = .ptM
        label.style = style.withWeight(.semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = .zero
        return label
    }()

    private lazy var statusView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(notPlayedStatusPill)
        stack.addArrangedSubview(playedStatusPill)
        stack.spacing = 10
        return stack
    }()

    private lazy var notPlayedStatusPill: PTPillButton = {
        let button = PTPillButton(title: "Not played") { [weak self] in
            self?.updateGameStatus(with: .notPlayed)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var playedStatusPill: PTPillButton = {
        let button = PTPillButton(title: "Played") { [weak self] in
            self?.updateGameStatus(with: .played)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var portrait: MediaView = {
        let imageView = MediaView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 97).isActive = true
        return imageView
    }()

    private let container: UIStackView = {
        let stack = UIStackView.initForAutolayout()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private var imageDownloadTask: DownloadTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupSubviews()
        navigationItem.title = "Game Detail"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageDownloadTask?.cancel()
        portrait.image = nil
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
        nameLabel.text = game?.name ?? "Unavailable"
        ratingView.rating = game?.rating
        releasedLabel.text = game?.released ?? "Not Released"
        portrait.media = game?.media
        if let playTime = game?.playTime {
            playtimeLabel.text = "Playtime: \(playTime)h"
        }
        playedStatusPill.isSelected = game?.status == .played
        notPlayedStatusPill.isSelected = game?.status == .notPlayed
        descriptionTitleLabel.isHidden = (game?.description?.isEmpty != true)
        descriptionBodyLabel.text = game?.description
        loadImage()
    }

    func loadImage() {
        imageDownloadTask = portrait.fetch(size: view.frame.size) { [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let value):
                guard let self = self else { return }
                self.portrait.image = value.image
                self.portrait.contentMode = .scaleAspectFill
                self.portrait.layoutIfNeeded()
            }
        }
    }

    func setupSubviews() {
        view.addSubviews([
            portrait,
            container
        ])
        [nameLabel,
         ratingTitleLabel,
         ratingView,
         releasedTitleLabel,
         releasedLabel,
         playtimeLabel,
         statusTitleLabel,
         statusView,
         descriptionTitleLabel,
         descriptionBodyLabel].forEach {
            container.addArrangedSubview($0)
        }
        container.setCustomSpacing(27, after: nameLabel)
        container.setCustomSpacing(10, after: ratingTitleLabel)
        container.setCustomSpacing(28, after: ratingView)
        container.setCustomSpacing(18, after: releasedTitleLabel)
        container.setCustomSpacing(18, after: releasedLabel)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.topAnchor.constraint(equalTo: portrait.topAnchor),
            portrait.leadingAnchor.constraint(equalTo: guide.leadingAnchor,
                                              constant: 17),
            guide.trailingAnchor.constraint(equalTo: portrait.trailingAnchor,
                                           constant: 17),
            container.topAnchor.constraint(equalTo: portrait.bottomAnchor,
                                           constant: Constants.belowImage),
            container.leadingAnchor.constraint(equalTo: portrait.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: portrait.trailingAnchor),
            container.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor)
        ])
    }

    func updateGameStatus(with status: GamePlayStatus) {
        guard let gameID = game?.id else {
            return
        }
        Task {
            do {
                try await PTClient.shared.updateGameStatus(gameID: gameID,
                                                           status: status)
                notPlayedStatusPill.isSelected = status == .notPlayed
                playedStatusPill.isSelected = status == .played
            } catch {
                debugPrint(String(describing: error))
            }
        }
    }
}
