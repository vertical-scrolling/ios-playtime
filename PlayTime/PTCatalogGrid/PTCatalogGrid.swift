//
//  PTCatalogGrid.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import UIKit

final class PTCatalogGrid: UIView {
    private lazy var dataSource: PTCatalogGridDataSource = .init(collectionView: collectionView)
    private var router: PTNavigationController?

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
        view.backgroundView = UIImageView(image: UIImage(named: "tetrisPattern"))
        return view
    }()

    convenience init(router: PTNavigationController?) {
        self.init(frame: .zero)
        self.router = router
    }

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
        dataSource.loadNextPage()
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
        dataSource.loadNextIfNeededPage(forItemAt: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let router = router,
           let id = dataSource.snapshot().itemIdentifiers[indexPath.item].id {
            router.navigateToGameDetail(id: id)
        }
    }
}
