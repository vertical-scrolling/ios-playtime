import Foundation

public protocol Endpoint {
    var path: String { get }
    var version: String { get }
    var urlComponents: URLComponents { get }
}

public enum PTEndpoint: String, Endpoint {
    case games

    public var path: String {
        switch self {
        case .games: return ""
        }
    }

    public var version: String {
        "v1.0"
    }

    private var queryItems: [URLQueryItem] {
        switch self {
        case .games: return [URLQueryItem(name: "q", value: self.rawValue)]
        }
    }

    public var urlComponents: URLComponents {
        var components = URLComponents(string: "\(path)/\(version)")!
        switch self {
        case .games:
            components.queryItems = queryItems
        }
        return components
    }
}
