//
//  PexelAPIRouter.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 26.07.2024.
//

import Foundation

/// Implement `PexelAPIRouter` that conforms to `Routable` protocol. All endpoint calls should be described here in separate cases of enum
enum PexelAPIRouter: Routable {
    
    /// Photos-curated endpoint
    ///
    /// ``https://www.pexels.com/api/documentation/#photos-curated``
    case curatedPhotos(page: Int?, perPage: Int?)
    
    // MARK: - Routable
    var path: String {
        switch self {
        case .curatedPhotos(let page, let perPage):
            switch (page, perPage) {
            case (nil, nil):
                return "curated/"
            case (nil, .some(let perPage)):
                return "curated?per_page=\(perPage)/"
            case (.some(let page), nil):
                return "curated?page=\(page)/"
            case (.some(let page), .some(let perPage)):
                return "curated?page=\(page)?per_page=\(perPage)/"
            }
        }
    }
    
    var method: String {
        switch self {
        case .curatedPhotos:
            return HttpMethod.GET.rawValue
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .curatedPhotos:
            return nil
        }
    }
}
