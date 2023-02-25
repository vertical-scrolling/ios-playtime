import UIKit

public protocol Client {
    func getGames(page: Int) async throws -> [Game]
}

public extension Client {
    func getGames() async throws -> [Game] {
        try await getGames(page: 1)
    }
}

public struct PTClient {
    public enum PTClientError: Error {
        case noEndpointURL
    }
    public static let shared: Client = PTClient()
}

extension PTClient: Client {
    public func getGames(page: Int) async throws -> [Game] {
        let gamesResource = PTGamesResource()
        guard var urlComponents = PTEndpoint().urlComponents(for: gamesResource) else {
            throw PTClientError.noEndpointURL
        }
        urlComponents.queryItems = [gamesResource.page(page)]
        guard let url = urlComponents.url else {
            throw PTClientError.noEndpointURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(GamesCollection.self, from: data).games
    }
}
