//
//  Filters.swift
//  
//
//  Created by Martín Sande on 25/2/23.
//

public enum PTParentFilter: Equatable {
    case genre
    case store
    case rating
    case platform

    public var title: String {
        switch self {
        case .genre: return "Genre"
        case .store: return "Store"
        case .rating: return "Rating"
        case .platform: return "Platform"
        }
    }

    public var values: [PTFilter] {
        switch self {
        case .genre: return [
            .init(title: "Sports", id: "15"),
            .init(title: "Fighting", id: "6"),
            .init(title: "Arcade", id: "11"),
            .init(title: "Simulation", id: "14"),
            .init(title: "Racing", id: "1"),
            .init(title: "Shooter", id: "2"),
            .init(title: "Action", id: "4"),
            .init(title: "Adventure", id: "3"),
            .init(title: "RPG", id: "5"),
        ]
        case .platform: return [
            .init(title: "Xbox", id: "80"),
            .init(title: "PlayStation 5", id: "187"),
            .init(title: "Game Boy Advance", id: "24"),
            .init(title: "Wii U", id: "10"),
            .init(title: "PlayStation", id: "27"),
            .init(title: "Nintendo 3DS", id: "8"),
            .init(title: "Wii", id: "11"),
            .init(title: "Nintendo DS", id: "9"),
        ]
        case .rating: return [
            .init(title: ">1", id: "1.00"),
            .init(title: ">2", id: "2.00"),
            .init(title: ">3", id: "3.00"),
            .init(title: ">4", id: "4.00"),
        ]
        case .store: return [
            .init(title: "Epic Games", id: "11"),
            .init(title: "Xbox Store", id: "2"),
            .init(title: "GOG", id: "5"),
            .init(title: "Google Play", id: "8"),
            .init(title: "Steam", id: "1"),
            .init(title: "App Store", id: "4"),
            .init(title: "PlayStation Store", id: "3")
        ]
        }
    }
}

public struct PTFilter: Equatable {
    public var title: String
    private let id: String

    init(title: String, id: String) {
        self.title = title
        self.id = id
    }
}
