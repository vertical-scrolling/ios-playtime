//
//  ViewController.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import UIKit
import PTClient
import PTDesignSystem

final class Home: UIViewController {
    private lazy var grid: PTCatalogGrid = .init(router: self.navigationController as? PTNavigationController)
    private var rawgInfoLabel: UIButton = {
        let label = PTLabel()
        var style: PTLabelStyle = .pt3XS
        label.style = style.withWeight(.light)
        label.text = "Data by RAWG API"
        label.textColor = .white
        var configuration = UIButton.Configuration.plain()
        configuration.buttonSize = .mini
        configuration.titleAlignment = .center
        configuration.attributedTitle = AttributedString(label.attributedText ?? NSAttributedString(string: ""))
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        button.addAction(UIAction { _ in
            if let link = URL(string: "https://rawg.io") {
                UIApplication.shared.open(link)
            }
        }, for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        grid.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(grid)
        view.addSubview(rawgInfoLabel)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.centerXAnchor.constraint(equalTo: rawgInfoLabel.centerXAnchor),
            guide.bottomAnchor.constraint(equalTo: rawgInfoLabel.bottomAnchor)
        ])
    }
}
