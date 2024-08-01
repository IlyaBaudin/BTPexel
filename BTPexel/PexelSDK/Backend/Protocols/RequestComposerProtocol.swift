//
//  RequestComposerProtocol.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 31.07.2024.
//

import Foundation

/// Abstraction that declare how to convert request of `Routable` type to some specific associated `RequestType`
protocol RequestComposerProtocol {
    
    associatedtype RequestType
    
    /// Perform `Routable` request transformation to some specific data type (like `URLRequest?` type)
    /// - Parameter request: any request that conforms to `Routable` protocol
    /// - Returns: `RequestType` object that has been composed using field from `Routable` protocol
    func compose(request: Routable) -> RequestType
}
