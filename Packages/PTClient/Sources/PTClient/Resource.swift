//
//  Resource.swift
//  
//
//  Created by Martín Sande on 25/2/23.
//

import Foundation
import UIKit

public protocol PTResource {
    var path: String { get }
}

public struct PTGamesResource: PTResource {
    public let path: String = "/games"
    public func pageQuery(for page: Int) -> URLQueryItem {
        URLQueryItem(name: "page", value: "\(page)")
    }
}

public struct PTGameDetailResource: PTResource {
    public var path: String { "/games/\(id)" }
    private let id: String

    init(id: String) {
        self.id = id
    }

    public func userQuery(for userID: String) -> URLQueryItem {
        URLQueryItem(name: "user_id", value: userID)
    }
}
