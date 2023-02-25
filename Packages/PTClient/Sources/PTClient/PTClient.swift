import UIKit

public protocol Client {
    func getGames() async throws -> [Game]
}

public struct PTClient {
    public enum PTClientError: Error {
        case noEndpointURL
    }
}

extension PTClient: Client {
    public func getGames() async throws -> [Game] {
        guard let url = PTEndpoint.games.urlComponents.url else {
            throw PTClientError.noEndpointURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Game].self, from: data)
    }
}
