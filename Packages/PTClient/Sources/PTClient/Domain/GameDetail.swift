//
//  GameDetail.swift
//  
//
//  Created by Martín Sande on 25/2/23.
//

import Foundation

public enum GamePlayStatus: String, Codable {
    case completed
    case notPlayed = "not_played"
}

struct GamePlayStatusPutObject: Codable {
    let status: GamePlayStatus

    init(status: GamePlayStatus) {
        self.status = status
    }
}

public struct GameDetail: Codable {
    public let id: String?
    public let name: String?
    public let released: String?
    public let rating: Double?
    public let media: Media?
    public let description: String?
    public let playTime: Double?
    public let status: GamePlayStatus?
}
