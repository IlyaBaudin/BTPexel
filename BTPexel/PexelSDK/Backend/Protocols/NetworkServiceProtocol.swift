//
//  NetworkServiceProtocol.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 27.07.2024.
//

import Foundation

/// Abstraction that should perform requests of type `Routable` over the network and return associated <`ResponseType`, `Error`> result. Any implementation can define any `ResponseType` that allow use different implementations if it's required or if communication protocol with Backend changed very often (like HTTP -> gRPC, or it was Parse backend and team would like migrate to custom backend based in HTTP/(S).
protocol NetworkServiceProtocol {
    
    associatedtype ResponseType
    
    /// `RequestComposerProtocol` implementation that perform necessary convert from `Routable` to some specific data type. Required
    var requestComposer: any RequestComposerProtocol { get }
    
    /// `RequestAdapterProtocol` implementation that allow to add some additional layer of request transformation like adding authorization token. Optional
    var requestAdapter: (any RequestAdapterProtocol)? { get set }
    
    /// Perform `Routable` request execution and return `Result<ResponseType, Error>` object callback
    /// - Parameters:
    ///   - request: any request that conforms to `Routable` protocol
    ///   - completion: `Result` callback for further handling
    func execute(request: Routable, completion: @escaping((Result<ResponseType, Error>) -> Void))
}
