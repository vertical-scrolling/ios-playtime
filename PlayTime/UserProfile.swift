//
//  UserProfile.swift
//  PlayTime
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit
import PTClient
import PTDesignSystem

final class UserProfile: UIViewController {
    private let userIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "perry"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 137).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 137).isActive = true
        imageView.layer.cornerRadius = 137/2
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let userNameLabel: PTLabel = {
        let label = PTLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.style = .ptXL
        label.text = "Guest"
        label.textColor = .greenApp
        return label
    }()

    private let playTimeTitle: PTLabel = {
        let label = PTLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        var style: PTLabelStyle = .ptM
        label.style = style.withWeight(.semibold)
        label.text = "Time lost of your life in video games"
        label.textColor = .white
        return label
    }()

    private let playedTimeIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "timePlayedIcon")?.withRenderingMode(.alwaysTemplate))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 102).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 67).isActive = true
        imageView.tintColor = .white
        return imageView
    }()

    private let playedTime: PTLabel = {
        let label = PTLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        var style: PTLabelStyle = .pt5XL
        label.style = style.withWeight(.bold)
        label.text = "3600h"
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBackground()
        setupSubviews()
    }

    private func setupBackground() {
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

    private func setupSubviews() {
        view.addSubview(userIcon)
        view.addSubview(userNameLabel)
        view.addSubview(playTimeTitle)
        view.addSubview(playedTimeIcon)
        view.addSubview(playedTime)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            userIcon.topAnchor.constraint(equalTo: guide.topAnchor,
                                          constant: 137),
            userIcon.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            userNameLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: userIcon.bottomAnchor,
                                               constant: 32),
            playTimeTitle.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            playTimeTitle.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor,
                                              constant: 100),
            playedTimeIcon.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            playedTimeIcon.topAnchor.constraint(equalTo: playTimeTitle.bottomAnchor,
                                               constant: 40),
            playedTime.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            playedTime.topAnchor.constraint(equalTo: playedTimeIcon.bottomAnchor,
                                            constant: 40)
        ])
    }
}
