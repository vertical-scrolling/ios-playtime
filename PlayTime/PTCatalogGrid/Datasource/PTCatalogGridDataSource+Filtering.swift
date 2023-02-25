//
//  PTCatalogGridDataSource+Filtering.swift
//  PlayTime
//
//  Created by Martín Sande on 25/2/23.
//

import Foundation
import PTClient

protocol PTCatalogGridDataSourceWithFilters {
    func filter(by filter: [PTFilter])
}

extension PTCatalogGridDataSource: PTCatalogGridDataSourceWithFilters {
    func filter(by filter: [PTFilter]) {
        print(filter.map { $0.title })
    }
}
