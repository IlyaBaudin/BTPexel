//
//  LegacyCompatibility.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 15.08.2025.
//

import protocol PexelSDK.PexelPhotoProtocol

public protocol LegacyPexelSDKInterface: AnyObject {
    var photos: [PexelSDK.PexelPhotoProtocol] { get }
    var dataLoadingError: Error? { get }
    var selectedPhoto: PexelSDK.PexelPhotoProtocol? { get }
    func getPhotos(isInitialLoad: Bool, completion: @escaping (Result<Void, Error>) -> Void)
    func selectPhoto(photo: PexelSDK.PexelPhotoProtocol)
}

@MainActor
public final class LegacyPexelSDKAdapter: @preconcurrency LegacyPexelSDKInterface {
    
    private let service: PexelService
    
    private var cachedPhotos: [PexelSDK.PexelPhotoProtocol] = []
    private var cachedError: Error?
    private var cachedSelected: PexelSDK.PexelPhotoProtocol? = nil
    
    private struct SDKPhotoAdapter: PexelSDK.PexelPhotoProtocol {
        var photoId: Double
        let photoUrl: String
        let photoTitle: String
        let authorName: String

        init(_ photo: PexelDomain.PexelPhoto) {
            self.photoId = Double(photo.id) ?? 0
            self.photoUrl = photo.photoUrl
            self.photoTitle = photo.photoTitle
            self.authorName = photo.authorName
        }
    }
    
    public init(service: PexelService) {
        self.service = service
    }
    
    public var photos: [any PexelSDK.PexelPhotoProtocol] {
        cachedPhotos
    }
    
    public var dataLoadingError: (any Error)? {
        cachedError
    }
    
    public var selectedPhoto: PexelSDK.PexelPhotoProtocol? {
        cachedSelected
    }
    
    public func getPhotos(isInitialLoad: Bool, completion: @escaping (Result<Void, any Error>) -> Void) {
        Task {
            await service.getPhotos(isInitialLoad: isInitialLoad)
            
            let items = await service.photos
            let error = await service.dataLoadingError
            
            self.cachedPhotos = items.map{ SDKPhotoAdapter($0) }
            self.cachedError = error
            
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    public func selectPhoto(photo: PexelSDK.PexelPhotoProtocol) {
        self.cachedSelected = photo
        guard let photo = photo as? PexelPhoto else {
            return
        }
        Task {
            await service.selectPhoto(photo)
        }
    }
}
