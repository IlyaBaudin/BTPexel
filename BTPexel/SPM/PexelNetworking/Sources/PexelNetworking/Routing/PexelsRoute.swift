//
//  PexelsRoute.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 27.08.2025.
//

import Foundation

public enum PexelsRoute: Sendable {
    case curated(page: Int, perPage: Int)
    
    var method: String {
        "GET"
    }
    
    var path: String {
        switch self {
        case .curated(_, _):
            "curated"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .curated(let page, let perPage):
            return [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "per_page", value: String(perPage))
            ]
        }
    }
}
