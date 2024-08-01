//
//  PexelBackend.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 27.07.2024.
//

import Foundation

/// Implementation of `PexelBackend` that can use any `NetworkService` that conforms to  `NetworkServiceProtocol`
final class PexelBackend<NetworkService: NetworkServiceProtocol>: BackendServiceProtocol {
    
    // MARK: - BackendServiceProtocol properties
    var networkService: NetworkService
    
    // MARK: - Init
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - BackendServiceProtocol methods
    func fetchData<ResultObject: Codable>(
        request: Routable,
        completion: @escaping((Result<ResultObject, Error>) -> Void)
    ) {
        networkService.execute(request: request) { result in
            switch result {
            case .success(let data):
                // check and cast response type
                guard let data = data as? Data else {
                    completion(.failure(PexelBackendError.incorrectResponseType))
                    return
                }
                
                do {
                    // try to decode `<ResultObject>` object
                    let decodedData = try JSONDecoder().decode(ResultObject.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    do {
                        // try to decode custom `PexelError` object (custom backend error)
                        let decodedPexelError = try JSONDecoder().decode(PexelError.self, from: data)
                        completion(.failure(decodedPexelError))
                    } catch {
                        // otherwise return default error
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                // return transport error from `NetworkServiceProtocol`
                completion(.failure(error))
            }
        }
    }
}
