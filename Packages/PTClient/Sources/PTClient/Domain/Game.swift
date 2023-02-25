import UIKit

struct GamesCollection: Codable {
    let games: [Game]
}

public struct Game: Codable {
    public let id: String?
    public let name: String?
    public let released: String?
    public let rating: Double?
    public let media: Media?

    public init(id: String?, name: String?, released: String?, rating: Double?, media: Media?) {
        self.id = id
        self.name = name
        self.released = released
        self.rating = rating
        self.media = media
    }
}
