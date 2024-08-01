//
//  HTTPRestError.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 27.07.2024.
//

import Foundation

/// Describe possible `HTTPRestService` execution errors
internal enum HTTPRestError: Error {
    /// Provided composer can't create correct request for execution
    case badUrl
    /// Income response of incorrect type
    case badResponse
    /// Provided incorrect type of composer and `HTTPRestService` can't build request for execution
    case requestBuildFailure
    /// Unexpected error when server return data = nil and error = nil but response has got correct type
    case unknown
}
