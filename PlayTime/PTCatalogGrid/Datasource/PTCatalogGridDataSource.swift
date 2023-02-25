//
//  PTCatalogGridDataSource.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import UIKit
import PTClient
import PTDesignSystem

enum CatalogGridSectionIdentifier: Hashable {
    case main
}

extension Game: Hashable {
    public func hash(into hasher: inout Hasher) {
        rating?.hash(into: &hasher)
        media?.url.hash(into: &hasher)
        id?.hash(into: &hasher)
        name?.hash(into: &hasher)
        released?.hash(into: &hasher)
    }

    public static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.rating == rhs.rating &&
        lhs.media?.url == rhs.media?.url &&
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.released == rhs.released
    }
}

class PTCatalogGridDataSource: UICollectionViewDiffableDataSource<CatalogGridSectionIdentifier, Game> {
    private var items: [Game] = []
    private var filters: [PTFilter] = []
    private var currentPage: Int = .zero
    private let supplementaryItemInvalidationContext: UICollectionViewLayoutInvalidationContext = {
        let invalidationContext = UICollectionViewLayoutInvalidationContext()
        invalidationContext.invalidateSupplementaryElements(ofKind: PTCatalogGridSupplementaryElementKind.gridHeader,
                                                            at: [IndexPath(item: .zero,
                                                                           section: .zero)])
        return invalidationContext
    }()
    private var isLoading = false

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
                let cell = collectionView.dequeueReusableSupplementaryView(ofKind: PTCatalogGridSupplementaryElementKind.gridHeader,
                                                                           withReuseIdentifier: GameGridHeaderView.reuseIdentifier,
                                                                           for: indexPath)
                guard let headerCell = cell as? GameGridHeaderView else {
                    return cell
                }
                headerCell.setup(with: [
                    .genre,
                    .store,
                    .rating,
                    .platform,
                ]) { [weak self] filter in
                    guard let self = self,
                          let filter = filter else {
                        return
                    }
                    collectionView.collectionViewLayout.invalidateLayout(with: self.supplementaryItemInvalidationContext)
                    if let filterAtIndex = self.filters.firstIndex(where: { $0 == filter }) {
                        self.filters.remove(at: filterAtIndex)
                    } else {
                        self.filters.append(filter)
                    }
                    self.filter(by: self.filters)
                }
                return headerCell
            default:
                return nil
            }
        }
    }

    func loadNextPage() {
        Task {
            let section: CatalogGridSectionIdentifier = .main
            do {
                items = try await PTClient.shared.getGames(page: currentPage + 1)
                isLoading = true
                var snapshot = snapshot()
                if snapshot.sectionIdentifiers.isEmpty {
                    snapshot.appendSections([.main])
                }
                snapshot.appendItems(items, toSection: section)
                apply(snapshot,
                      animatingDifferences: true) { [weak self] in
                    self?.currentPage += 1
                    self?.isLoading = false
                }
            } catch {
                debugPrint("Failed to load games \(error.localizedDescription)")
            }
        }
    }

    func loadNextIfNeededPage(forItemAt indexPath: IndexPath) {
        if snapshot().itemIdentifiers[indexPath.item] == snapshot().itemIdentifiers.last,
           !isLoading {
            loadNextPage()
        }
    }
}
