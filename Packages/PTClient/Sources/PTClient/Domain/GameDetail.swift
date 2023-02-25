//
//  GameDetail.swift
//  
//
//  Created by Martín Sande on 25/2/23.
//

import Foundation

public enum GamePlayStatus: String, Codable {
    case played
    case notPlayed = "not_played"
}

public struct GameDetail: Codable {
    public let name: String?
    public let released: String?
    public let rating: Double?
    public let media: Media?
    public let description: String?
    public let playTime: Double?
    public let status: GamePlayStatus?
}
