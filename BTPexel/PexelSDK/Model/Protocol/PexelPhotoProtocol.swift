//
//  PexelPhotoProtocol.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 31.07.2024.
//

import Foundation

public protocol PexelPhotoProtocol {
    /// Pexel photo object identifier
    var photoId: Double { get }
    /// Pexel photo object URL
    var photoUrl: String { get }
    /// Pexel photo author name
    var authorName: String { get }
    /// Pexel photo title
    var photoTitle: String { get }
}
