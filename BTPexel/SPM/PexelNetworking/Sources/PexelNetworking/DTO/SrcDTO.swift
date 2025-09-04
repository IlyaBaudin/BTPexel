//
//  SrcDTO.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 28.08.2025.
//

import Foundation

public struct SrcDTO: Decodable, Sendable {
    public let original: String
    public let large2x: String
    public let large: String
    public let medium: String
}
