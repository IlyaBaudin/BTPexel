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
    private let photo: PexelPhoto
    
    let titleText: String
    let authorText: String
    let previewUrl: URL?
    let hiResUrl: URL?
    
    init(photo: PexelPhoto) {
        self.photo = photo
        self.titleText = photo.photoTitle
        self.authorText = photo.authorName
        self.previewUrl = URL(string: photo.photoUrl)
        self.hiResUrl = photo.hiResUrl.flatMap(URL.init(string: ))
    }
}
