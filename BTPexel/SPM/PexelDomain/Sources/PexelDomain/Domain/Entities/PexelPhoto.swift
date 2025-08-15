//
//  File.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

import Foundation

public struct PexelPhoto: PexelPhotoProtocol, Sendable, Equatable {
    
    // MARK: - Properties PexelPhotoProtocol
    public var id: String
    public var photoTitle: String
    public var authorName: String
    public var photoUrl: String
    
    // MARK: - Init
    public init(id: String, photoTitle: String, authorName: String, photoUrl: String) {
        self.id = id
        self.photoTitle = photoTitle
        self.authorName = authorName
        self.photoUrl = photoUrl
    }
}
