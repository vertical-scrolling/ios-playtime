//
//  PTFilterView.swift
//  
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit

public protocol PTFilterViewModel {
    var title: String { get }
    var items: [PTFilterItemViewModel] { get }
}

public class PTFilterView: UIStackView {
    private let parentsRow: PTFilterRow = .init()
    private let valuesRow: PTFilterRow = .init()

    public var actionHandler: ((PTFilterItemViewModel) -> Void)?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setup(with filters: [PTFilterViewModel]) {
        parentsRow.setup(with: filters) { [weak self] parentFilter in
            self?.setupChildrenFilters(items: parentFilter.items)
        }
    }
}

private extension PTFilterView {
    func setupView() {
        axis = .vertical
        spacing = 18
        addArrangedSubview(parentsRow)
        addArrangedSubview(valuesRow)
        valuesRow.isHidden = true
    }

    func setupChildrenFilters(items: [PTFilterItemViewModel]) {
        valuesRow.setup(with: items) { [weak self] filterItem in
            self?.actionHandler?(filterItem)
        }
        valuesRow.isHidden = items.isEmpty
    }
}
