import UIKit

public protocol Client {
    func getGames(page: Int) async throws -> [Game]
    func getGameDetail(id: String) async throws -> GameDetail
    func updateGameStatus(gameID: String,
                          status: GamePlayStatus) async throws
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
        urlComponents.queryItems = [gamesResource.pageQuery(for: page)]
        guard let url = urlComponents.url else {
            throw PTClientError.noEndpointURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(GamesCollection.self, from: data).games
    }

    public func getGameDetail(id: String) async throws -> GameDetail {
        let gamesResource = PTGameDetailResource(id: id)
        guard var urlComponents = PTEndpoint().urlComponents(for: gamesResource) else {
            throw PTClientError.noEndpointURL
        }
        if let deviceKey = await UIDevice.current.identifierForVendor?.uuidString {
            urlComponents.queryItems = [gamesResource.userQuery(for: deviceKey)]
        }
        guard let url = urlComponents.url else {
            throw PTClientError.noEndpointURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(GameDetail.self, from: data)
    }

    public func updateGameStatus(gameID: String,
                                 status: GamePlayStatus) async throws {
        guard let deviceID = await UIDevice.current.identifierForVendor?.uuidString else {
            throw PTClientError.noEndpointURL
        }
        let gamesResource = PTGameStatusResource(userID: deviceID,
                                                 gameID: gameID)
        guard let url = PTEndpoint().urlComponents(for: gamesResource)?.url else {
            throw PTClientError.noEndpointURL
        }
        let putObject = GamePlayStatusPutObject(status: status)
        let jsonData = try JSONEncoder().encode(putObject)
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request)
    }
}
