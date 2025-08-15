//
//  SrcResponse.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 31.07.2024.
//

import Foundation

public struct SrcResponse: Codable {
    public let original: String
    public let large2x: String
    public let large: String
    public let medium: String
}
