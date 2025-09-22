//
//  PhotoDetailViewModel.swift
//  BTPexel
//
//  Created by Ilia Baudin on 04.09.2025.
//

import Foundation
import PexelDomain

@MainActor
final class PhotoDetailViewModel {
    private let service: PexelService
    private(set) var photo: PexelPhoto
    
    var titleText: String { photo.photoTitle }
    var authorText: String { photo.authorName }
    var previewUrl: URL? { URL(string: photo.photoUrl) }
    var hiResUrl: URL? { photo.hiResUrl.flatMap(URL.init(string: )) }
    
    init(photo: PexelPhoto, service: PexelService) {
        self.photo = photo
        self.service = service
        Task { [photo, service] in
            await service.selectPhoto(photo)
        }
    }
    
    func clearSelection() {
        Task { [service] in
            await service.clearPhoto()
        }
    }
    
}
