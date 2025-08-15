//
//  PexelPhoto.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 26.07.2024.
//

import Foundation

/// Represent `PexelPhoto` object from backend. Conforms to `PexelPhotoProtocol` and used on UI part to describe objects
public struct PexelPhoto: PexelPhotoProtocol, Codable {
    
    enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case postUrl = "url"
        case authorName = "photographer"
        case photoTitle = "alt"
        case src
    }
    
    // MARK: - PexelPhotoProtocol
    public let photoId: Double
    public var photoUrl: String {
        src.large
    }
    public let authorName: String
    public let photoTitle: String
    
    // MARK: Codable fields
    public let postUrl: String
    public let src: SrcResponse
}
