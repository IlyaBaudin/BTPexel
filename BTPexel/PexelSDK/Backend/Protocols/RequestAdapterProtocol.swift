//
//  RequestAdapterProtocol.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 31.07.2024.
//

import Foundation

/// Abstraction that add some additional layer of transformation to request
protocol RequestAdapterProtocol {
    
    associatedtype RequestType
    
    /// Perform `RequestType` transformation by adding some new data to that request (like auth token, or something else)
    /// - Parameter request: `RequestType` object
    /// - Returns: transformed `RequestType` object 
    func adapt(request: RequestType) -> RequestType
}
