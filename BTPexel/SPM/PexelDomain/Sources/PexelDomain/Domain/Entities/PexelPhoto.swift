//
//  PexelPhoto.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

import Foundation

public struct PexelPhoto: Sendable, Equatable {
    
    // MARK: - Properties
    public var id: String
    public var photoTitle: String
    public var authorName: String
    public var photoUrl: String
    public var hiResUrl: String?
    
    // MARK: - Init
    public init(id: String, photoTitle: String, authorName: String, photoUrl: String, hiResUrl: String? = nil) {
        self.id = id
        self.photoTitle = photoTitle
        self.authorName = authorName
        self.photoUrl = photoUrl
        self.hiResUrl = hiResUrl
    }
}
