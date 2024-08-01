//
//  Routable.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 26.07.2024.
//

import Foundation

/// Define alias for request `Parameters` dictionary
typealias Parameters = [String: Any]

/// Define abstract routing object for requests
protocol Routable {
    /// endpoint path
    var path: String { get }
    /// expected endpoint method for manipulating data
    var method: String { get }
    /// expected parameters for that route
    var parameters: Parameters? { get }
}
