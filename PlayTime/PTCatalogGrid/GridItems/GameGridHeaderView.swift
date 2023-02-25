//
//  GameGridHeaderView.swift
//  PlayTime
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit
import PTDesignSystem
import PTClient

extension PTParentFilter: PTFilterViewModel {
    public var items: [PTDesignSystem.PTFilterItemViewModel] {
        values as [PTFilterItemViewModel]
    }
}
extension PTFilter: PTFilterItemViewModel {
    public var isParentFilter: Bool {
        false
    }
}

final class GameGridHeaderView: UICollectionReusableView {
    private let title: PTLabel = {
        let view = PTLabel.init()
        var style: PTLabelStyle = .ptM
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = style.withWeight(.medium)
        view.text = "Games"
        return view
    }()
    private let filtersView: PTFilterView = {
        let filterView = PTFilterView()
        filterView.translatesAutoresizingMaskIntoConstraints = false
        return filterView
    }()

    static let reuseIdentifier: String = "GameGridHeaderViewReuseIdentifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with filters: [PTParentFilter], actionHandler: @escaping (PTFilter?) -> Void) {
        filtersView.actionHandler = { filterItem in
            let filterItem = filterItem as? PTFilter
            actionHandler(filterItem)
        }
        filtersView.setup(with: filters)
    }
}

private extension GameGridHeaderView {
    func setupView() {
        filtersView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(filtersView)
        addSubview(title)

        NSLayoutConstraint.activate([
            filtersView.topAnchor.constraint(equalTo: topAnchor,
                                             constant: 27),
            filtersView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: 21),
            trailingAnchor.constraint(equalTo: filtersView.trailingAnchor,
                                      constant: 21),
            title.topAnchor.constraint(equalTo: filtersView.bottomAnchor,
                                       constant: 18),
            title.leadingAnchor.constraint(equalTo: filtersView.leadingAnchor),
            title.trailingAnchor.constraint(lessThanOrEqualTo: filtersView.trailingAnchor),
            bottomAnchor.constraint(equalTo: title.bottomAnchor,
                                    constant: 9)
        ])
    }
}
