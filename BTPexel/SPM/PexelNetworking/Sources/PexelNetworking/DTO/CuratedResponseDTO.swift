//
//  CuratedResponseDTO.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 28.08.2025.
//

import Foundation

public struct CuratedResponseDTO: Decodable, Sendable {
    public let page: Int
    public let per_page: Int
    public let photos: [PhotoDTO]
}
