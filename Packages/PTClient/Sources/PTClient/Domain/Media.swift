import UIKit

public struct Media: Codable {
    public let url: String?

    public enum MediaError: Error {
        case invalidURL
    }

    public init(url: String) {
        self.url = url
    }
}
