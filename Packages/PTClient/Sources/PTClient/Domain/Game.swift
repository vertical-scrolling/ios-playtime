import UIKit

public struct Game: Codable {
    public let id: String
    public let name: String
    public let released: String
    public let rating: Int
    public let media: Media

    public init(id: String, name: String, released: String, rating: Int, media: Media) {
        self.id = id
        self.name = name
        self.released = released
        self.rating = rating
        self.media = media
    }
}
