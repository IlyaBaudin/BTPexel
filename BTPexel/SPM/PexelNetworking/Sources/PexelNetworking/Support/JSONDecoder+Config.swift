//
//  JSONDecoder+Config.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 28.08.2025.
//

import Foundation

extension JSONDecoder {
    public static func pexels() -> JSONDecoder {
        var decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
