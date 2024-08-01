//
//  PexelPhoto.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 26.07.2024.
//

import Foundation

/// Represent `PexelPhoto` object from backend. Conforms to `PexelPhotoProtocol` and used on UI part to describe objects
struct PexelPhoto: PexelPhotoProtocol, Codable {
    
    enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case postUrl = "url"
        case authorName = "photographer"
        case photoTitle = "alt"
        case src
    }
    
    // MARK: - PexelPhotoProtocol
    let photoId: Double
    var photoUrl: String {
        src.large
    }
    let authorName: String
    let photoTitle: String
    
    // MARK: Codable fields
    let postUrl: String
    let src: SrcResponse
}
