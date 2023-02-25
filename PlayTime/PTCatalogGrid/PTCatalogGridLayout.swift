//
//  PTCatalogGridLayout.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import UIKit

struct PTCatalogGridSupplementaryElementKind {
    static let gridHeader: String = "PTCatalogGridHeaderElementKind"
}

final class PTCatalogGridLayout: UICollectionViewCompositionalLayout {
    private struct Constants {
        static let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(0.4853),
                                                            heightDimension: .fractionalHeight(1.0))
        static let groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0),
                                                             heightDimension: .absolute(265))
        static let groupInsets: NSDirectionalEdgeInsets = .init(horizontal: 21)
        static let interItemSpacing: NSCollectionLayoutSpacing = .fixed(8)
        static let interGroupSpacing: CGFloat = 24
        static let headerHeight: NSCollectionLayoutDimension = .estimated(17)
    }

    convenience init() {
        let itemSize: NSCollectionLayoutSize = Constants.itemSize
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        let groupSize: NSCollectionLayoutSize = Constants.groupSize
        let group: NSCollectionLayoutGroup = .horizontal(layoutSize: groupSize,
                                                         subitems: [item, item])
        group.contentInsets = Constants.groupInsets
        group.interItemSpacing = Constants.interItemSpacing
        let section: NSCollectionLayoutSection = .init(group: group)
        section.interGroupSpacing = Constants.interGroupSpacing
        let configuration: UICollectionViewCompositionalLayoutConfiguration = .init()
        let header: NSCollectionLayoutBoundarySupplementaryItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                          heightDimension: Constants.headerHeight),
                                                                        elementKind: PTCatalogGridSupplementaryElementKind.gridHeader,
                                                                        alignment: .top)
        configuration.boundarySupplementaryItems = [header]
        self.init(section: section, configuration: configuration)
    }
}

private extension NSDirectionalEdgeInsets {
    init(horizontal: CGFloat) {
        self.init(top: .zero,
                  leading: horizontal,
                  bottom: .zero,
                  trailing: horizontal)
    }
}
