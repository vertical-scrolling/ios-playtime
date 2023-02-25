//
//  PTNavigationController.swift
//  PlayTime
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit
import PTDesignSystem
import PTClient

final class PTNavigationController: UINavigationController {
    private let userProfile = UserProfile(nibName: nil, bundle: nil)
    private let gameDetailPage = GameDetailPage(nibName: nil, bundle: nil)

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupNavBar()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNavBar()
    }

    func navigateToGameDetail(id: String) {
        Task {
            do {
                gameDetailPage.game = try await PTClient.shared.getGameDetail(id: id)
            } catch {
                debugPrint(String(describing: error))
            }
        }
        pushViewController(gameDetailPage, animated: true)
    }
}

extension PTNavigationController: PTNavigationBarHandler { }

private extension PTNavigationController {
    func setupNavBar() {
        addNavBarProfileIcon { [weak self] in self?.touchUpProfile() }
        addNavBarSearchBar { [weak self] in self?.touchUpSearch() }
    }

    func touchUpProfile() {
        if let sheet = userProfile.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.largestUndimmedDetentIdentifier = .large
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(userProfile, animated: true, completion: nil)
    }

    func touchUpSearch() {
        print("touch up search")
    }

    func searchAction() {
        print("touch up search")
    }
}
