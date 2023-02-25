import Foundation

public protocol Endpoint {
    var base: String { get }
    var version: String { get }
    func urlComponents(for resource: PTResource) -> URLComponents?
}

public struct PTEndpoint: Endpoint {
    public let base: String = "https://playtime.fly.dev"

    public var version: String { "/1" }

    public func urlComponents(for resource: PTResource) -> URLComponents? {
        URLComponents(string: "\(base)\(version)\(resource.path)")
    }
}
