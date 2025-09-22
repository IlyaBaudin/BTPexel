//
//  PhotoDTO.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 28.08.2025.
//

import Foundation

public struct PhotoDTO: Decodable, Sendable {
    public let id: Double
    public let url: String
    public let photographer: String
    public let alt: String
    public let src: SrcDTO
}
