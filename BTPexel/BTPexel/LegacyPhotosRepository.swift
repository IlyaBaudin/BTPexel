//
//  LegacyPhotosRepository.swift
//  BTPexel
//
//  Created by Ilia Baudin on 15.08.2025.
//

import Foundation
import PexelDomain
import PexelSDK

final class LegacyPhotosRepository: PhotosRepository, @unchecked Sendable {
    
    private let backend: PexelBackend<HTTPRestService>
    
    init(backend: PexelBackend<HTTPRestService>) {
        self.backend = backend
    }
    
    func fetchCurated(page: Int, perPage: Int) async throws -> [PexelDomain.PexelPhoto] {
        let route = PexelAPIRouter.curatedPhotos(page: page, perPage: perPage)
        
        return try await withCheckedThrowingContinuation { cont in
            backend.fetchData(request: route) { (result: Result<PexelSDK.PexelCuratedResponse, Error>) in
                switch result {
                case .success(let success):
                    let items: [PexelDomain.PexelPhoto] = success.photos.map { photo in
                        let idStr: String = {
                            if photo.photoId.rounded() == photo.photoId {
                                return "\(Int64(photo.photoId))"
                            } else {
                                return "\(photo.photoId)"
                            }
                        }()
                        
                        let url = photo.src.large
                        
                        return PexelDomain.PexelPhoto(
                            id: idStr,
                            photoTitle: photo.photoTitle,
                            authorName: photo.authorName,
                            photoUrl: url
                        )
                    }
                    cont.resume(returning: items)
                case .failure(let error):
                    cont.resume(throwing: error)
                }
            }
        }
    }
    
    
}
