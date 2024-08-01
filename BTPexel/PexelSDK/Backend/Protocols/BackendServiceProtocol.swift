//
//  BackendServiceProtocol.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 27.07.2024.
//

import Foundation

/// Abstraction for logical backend service that allow us to send `Routable` requests and return `Result<ResultObject, Error>`. Include network layer of sending requests and parsing layer that transform network response to objects
protocol BackendServiceProtocol {
    
    associatedtype NetworkService: NetworkServiceProtocol
    
    /// Any NetworkService that conforms to `NetworkServiceProtocol`
    var networkService: NetworkService { get }
    
    /// Fetch some data from backend. Method allow to define generic type of `ResultObject`.
    /// - Parameters:
    ///   - request: any `Routable` item
    ///   - completion: callback with `Result<Object, Error>`
    func fetchData<ResultObject: Codable>(
        request: Routable,
        completion: @escaping((Result<ResultObject, Error>) -> Void)
    )
}
