//
//  PexelError.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 27.07.2024.
//

import Foundation

struct PexelError: Codable, Error {
    let status: Int
    let code: String
}
