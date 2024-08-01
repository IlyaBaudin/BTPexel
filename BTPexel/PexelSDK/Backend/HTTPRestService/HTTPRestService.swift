//
//  HTTPRestService.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 27.07.2024.
//

import Foundation

/// Implementation of `NetworkServiceProtocol` that use HTTPRest backend with basic `URLRequest`s and response type of `Data`
final class HTTPRestService: NetworkServiceProtocol {
    
    typealias ResponseType = Data
    
    // MARK: - Private properties
    /// `URLSession` object with custom or default configuration to perform `URLRequest`
    private let urlSession: URLSession
    /// Queue for requests execution
    private let httpRestServiceQueue: DispatchQueue
    
    // MARK: - NetworkServiceProtocol properties
    internal var requestComposer: any RequestComposerProtocol
    internal var requestAdapter: (any RequestAdapterProtocol)?
    
    // MARK: - Init
    /// Create `HTTPRestService` with required `RequestComposerProtocol` object. `RequestComposerProtocol` define how to create requests for execution.
    /// - Parameter requestComposer: composer that conforms to `RequestComposerProtocol`
    init(requestComposer: any RequestComposerProtocol) {
        urlSession = URLSession(configuration: .ephemeral)
        httpRestServiceQueue = DispatchQueue(label: "com.BTPexel.httpRestServiceQueue", qos: .userInitiated)
        self.requestComposer = requestComposer
    }
    
    // MARK: - NetworkServiceProtocol methods
    internal func execute(request: any Routable, completion: @escaping ((Result<Data, any Error>) -> Void)) {
        
        guard let composer = requestComposer as? UrlRequestComposer else {
            completion(.failure(HTTPRestError.requestBuildFailure))
            return
        }
        
        guard var urlRequest = composer.compose(request: request) else {
            completion(.failure(HTTPRestError.badUrl))
            return
        }
        
        if let authAdapter = requestAdapter as? UrlBasicAuthRequestAdapter {
            urlRequest = authAdapter.adapt(request: urlRequest)
        }
        
        httpRestServiceQueue.async {
            self.urlSession.dataTask(with: urlRequest) { data, response, error in
                // handle case when response of incorrect type
                guard response is HTTPURLResponse else {
                    completion(.failure(HTTPRestError.badResponse))
                    return
                }
                // handle case when response if correct but for some reason instead of data server send a error
                guard let data else {
                    let error = error ?? HTTPRestError.unknown
                    completion(.failure(error))
                    return
                }
                // otherwise return success result with `Data`
                completion(.success(data))
            }.resume()
        }
    }
}
