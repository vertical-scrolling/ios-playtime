//
//  PTNavigationBarHandler.swift
//  PlayTime
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit
import PTDesignSystem

protocol PTNavigationBarHandler {
    func addNavBarProfileIcon(actionHandler: @escaping () -> Void)
    func addNavBarSearchButton(actionHandler: @escaping () -> Void)
    func addNavBarSearchBar(actionHandler: @escaping () -> Void)
}

extension PTNavigationBarHandler where Self: PTNavigationController {
    func addNavBarSearchBar(actionHandler: @escaping () -> Void) {
        let searchField = UISearchTextField(frame: .init(origin: .zero,
                                                         size: .init(width: 189, height: 18)),
                                            primaryAction: UIAction { _ in
            actionHandler()
        })
        let label = PTLabel()
        var placeHolderStyle: PTLabelStyle = .ptS
        label.style = placeHolderStyle.withWeight(.light)
        label.textColor = .darkGray
        label.text = "Search..."
        searchField.attributedPlaceholder = label.attributedText
        navigationBar.topItem?.titleView = searchField
    }

    func addNavBarProfileIcon(actionHandler: @escaping () -> Void) {
        let iconButton = UIButton(frame: .zero)
        iconButton.addAction(UIAction { _ in
            actionHandler()
        }, for: .touchUpInside)
        iconButton.setImage(UIImage(named: "profileIcon"), for: .normal)
        navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: iconButton)
    }

    func addNavBarSearchButton(actionHandler: @escaping () -> Void) {
        let searchButton = UIButton(frame: .zero)
        searchButton.addAction(UIAction { _ in
            actionHandler()
        }, for: .touchUpInside)
        let label = PTLabel()
        label.style = .ptM
        label.text = "SEARCH"
        label.textColor = .greenApp
        searchButton.setAttributedTitle(label.attributedText, for: .normal)
        navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
    }
}
