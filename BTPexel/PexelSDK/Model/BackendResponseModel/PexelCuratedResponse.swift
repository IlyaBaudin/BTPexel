//
//  PexelCuratedResponse.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 27.07.2024.
//

import Foundation

struct PexelCuratedResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
    }
    
    let page: Int
    let perPage: Int
    let photos: [PexelPhoto]
}
