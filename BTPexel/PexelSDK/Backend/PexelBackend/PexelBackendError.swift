//
//  PexelBackendError.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 31.07.2024.
//

import Foundation

/// Describe possible custom `PexelBackend` execution errors
internal enum PexelBackendError: Error {
    /// `NetworkServiceProtocol` implementation returns incorrect response type
    case incorrectResponseType
}
