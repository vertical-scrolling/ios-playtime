//
//  PTFilterRow.swift
//  
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit

public protocol PTFilterItemViewModel {
    var title: String { get }
    var isParentFilter: Bool { get }
}

public class PTFilterRow: UIScrollView {
    private let container: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setup(with filters: [PTFilterItemViewModel],
                      actionHandler: @escaping (PTFilterItemViewModel) -> Void) {
        container.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        filters.forEach { filter in
            let filterPill = PTPillButton(title: filter.title) {
                actionHandler(filter)
            }
            container.addArrangedSubview(filterPill)
        }
    }

    public func setup(with parentFilters: [PTFilterViewModel],
                      actionHandler: @escaping (PTFilterViewModel) -> Void) {
        container.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        parentFilters.forEach { filter in
            let filterPill = PTPillButton(title: filter.title) {
                actionHandler(filter)
            }
            container.addArrangedSubview(filterPill)
        }
    }
}

private extension PTFilterRow {
    func setupView() {
        addSubview(container)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            trailingAnchor.constraint(equalTo: container.trailingAnchor),
            container.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
