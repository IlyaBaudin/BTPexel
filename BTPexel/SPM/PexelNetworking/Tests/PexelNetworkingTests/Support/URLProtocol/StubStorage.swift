//
//  StubStorage.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 22.09.2025.
//

import Foundation

final class StubStorage {
    typealias RespBlock = (URLRequest) -> (HTTPURLResponse, Data)
    typealias ErrBlock  = (URLRequest) -> Error

    private var resp: RespBlock?
    private var err: ErrBlock?
    private var last: URLRequest?

    private let queue = DispatchQueue(label: "StubURLProtocol.Storage")

    func setResponse(_ block: RespBlock?) {
        queue.sync { resp = block }
    }
    
    func setError(_ block: ErrBlock?) {
        queue.sync { err  = block }
    }
    
    func reset() {
        queue.sync {
            resp = nil
            err = nil
            last = nil
        }
    }

    func capture(_ request: URLRequest) {
        queue.sync {
            last = request
        }
    }
    
    func response(for req: URLRequest) -> (HTTPURLResponse, Data)? {
        queue.sync {
            resp?(req)
        }
    }
    
    func error(for req: URLRequest) -> Error? {
        queue.sync {
            err?(req)
        }
    }
    
    func lastRequest() -> URLRequest? {
        queue.sync {
            last
        }
    }
}
