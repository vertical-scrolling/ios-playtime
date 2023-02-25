//
//  PTCatalogGridDataSource.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import UIKit
import PTClient

enum CatalogGridSectionIdentifier: Hashable {
    case main
}

extension Game: Hashable {
    public func hash(into hasher: inout Hasher) {
        rating.hash(into: &hasher)
        media.url.hash(into: &hasher)
        id.hash(into: &hasher)
        name.hash(into: &hasher)
        released.hash(into: &hasher)
    }

    public static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.rating == rhs.rating &&
        lhs.media.url == rhs.media.url &&
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.released == rhs.released
    }
}

class PTCatalogGridDataSource: UICollectionViewDiffableDataSource<CatalogGridSectionIdentifier, Game> {
    private func mockItem(with id: Int) -> Game {
        .init(id: "\(id)",
              name: "Hogwarts legacy",
              released: "2022",
              rating: 70,
              media: .init(url: "https://image.api.playstation.com/vulcan/ap/rnd/202011/0919/cDHU28ds7cCvKAnVQo719gs0.png"))
    }
    private var items: [Game] = []

    convenience init(collectionView: UICollectionView) {
        self.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameGridCell.reuseIdentifier,
                                                          for: indexPath)
            guard let gameGridCell = cell as? GameGridCell else {
                return cell
            }
            gameGridCell.viewModel = itemIdentifier
            return gameGridCell
        }

        supplementaryViewProvider = { collectionView, elementKind, indexPath in
            switch elementKind {
            case PTCatalogGridSupplementaryElementKind.gridHeader:
                return collectionView.dequeueReusableSupplementaryView(ofKind: PTCatalogGridSupplementaryElementKind.gridHeader,
                                                                       withReuseIdentifier: GameGridHeaderView.reuseIdentifier,
                                                                       for: indexPath)
            default:
                return nil
            }
        }
    }

    func loadItems() {
        let section: CatalogGridSectionIdentifier = .main
        items = (0...10).map { mockItem(with: $0) }
        var snapshot = NSDiffableDataSourceSnapshot<CatalogGridSectionIdentifier, Game>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        apply(snapshot,
              animatingDifferences: true)
    }
}
