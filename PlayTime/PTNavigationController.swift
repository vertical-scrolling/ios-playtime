//
//  PTNavigationController.swift
//  PlayTime
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit
import PTDesignSystem

final class PTNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupNavBar()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNavBar()
    }
}

extension PTNavigationController: PTNavigationBarHandler { }

private extension PTNavigationController {
    func setupNavBar() {
        addNavBarProfileIcon { [weak self] in self?.touchUpProfile() }
        addNavBarSearchButton { [weak self] in self?.touchUpSearch() }
        addNavBarSearchBar { [weak self] in self?.touchUpSearch() }
    }

    func touchUpProfile() {
        print("touch up profile")
    }

    func touchUpSearch() {
        print("touch up search")
    }

    func searchAction() {
        print("touch up search")
    }
}
