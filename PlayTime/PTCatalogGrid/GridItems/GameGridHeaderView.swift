//
//  GameGridHeaderView.swift
//  PlayTime
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit
import PTDesignSystem

final class GameGridHeaderView: UICollectionReusableView {
    private let title: PTLabel = .init()

    static let reuseIdentifier: String = "GameGridHeaderViewReuseIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        var style: PTLabelStyle = .ptM
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.fitToSuperview(with: .init(top: .zero,
                                         left: 21,
                                         bottom: 9,
                                         right: 21))
        title.style = style.withWeight(.medium)
        title.text = "Games"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
