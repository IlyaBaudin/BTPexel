//
//  FeedViewModel.swift
//  BTPexel
//
//  Created by Ilia Baudin on 03.09.2025.
//

import Foundation
import PexelDomain

@MainActor
final class FeedViewModel {
    private let service: PexelService
    
    private(set) var photos: [PexelPhoto] = []
    private(set) var loadingError: Error?
    
    init(service: PexelService) {
        self.service = service
    }
    
    func reload() async {
        await service.getPhotos(isInitialLoad: true)
        await pullShapshot()
    }
    
    func loadMore() async {
        await service.getPhotos(isInitialLoad: false)
        await pullShapshot()
    }
    
    private func pullShapshot() async {
        self.photos = await service.photos
        self.loadingError = await service.dataLoadingError
    }
}
