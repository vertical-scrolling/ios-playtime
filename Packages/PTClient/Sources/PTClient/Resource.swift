//
//  Resource.swift
//  
//
//  Created by Martín Sande on 25/2/23.
//

import Foundation

public protocol PTResource {
    var path: String { get }
}

public struct PTGamesResource: PTResource {
    public let path: String = "/games"
    public func page(_ page: Int) -> URLQueryItem {
        URLQueryItem(name: "page", value: "\(page)")
    }
}
