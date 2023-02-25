//
//  GameGridCellViewModel.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import PTClient

protocol GameGridCellViewModel {
    var name: String { get }
    var released: String { get }
    var rating: Int { get }
    var media: Media { get }
}

extension Game: GameGridCellViewModel { }

protocol ResponsiveCell {
    func loadImage()
}
