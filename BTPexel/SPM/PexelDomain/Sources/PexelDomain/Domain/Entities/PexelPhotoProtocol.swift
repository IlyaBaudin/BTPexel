//
//  PexelPhotoProtocol.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

import Foundation

public protocol PexelPhotoProtocol {
    var id: String { get }
    var photoTitle: String { get }
    var authorName: String { get }
    var photoUrl: String { get }
}
