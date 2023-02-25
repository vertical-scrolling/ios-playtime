//
//  PTCatalogGrid.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import UIKit

final class PTCatalogGrid: UIView {
    private lazy var dataSource: PTCatalogGridDataSource = .init(collectionView: collectionView)

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: PTCatalogGridLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.register(GameGridCell.self,
                      forCellWithReuseIdentifier: GameGridCell.reuseIdentifier)
        view.register(GameGridHeaderView.self,
                      forSupplementaryViewOfKind: PTCatalogGridSupplementaryElementKind.gridHeader,
                      withReuseIdentifier: GameGridHeaderView.reuseIdentifier)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.fitToSuperview()
        dataSource.loadItems()
    }
}

private extension PTCatalogGrid {
    func setupView() {
        addSubview(collectionView)
        collectionView.fitToSuperview()
    }
}

extension PTCatalogGrid: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if let cell = cell as? ResponsiveCell {
            cell.loadImage()
        }
    }
}
