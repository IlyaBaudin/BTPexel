//
//  PhotosListViewModel.swift
//  BTPexel
//
//  Created by Ilia Baudin on 22.09.2025.
//

import Foundation
import PexelDomain

@MainActor
final class PhotosListViewModel: ObservableObject {
    
    @Published private(set) var items: [PexelPhoto] = []
    @Published var alertMessage: String?
    @Published var isLoading: Bool = false
    
    private let service: PexelService
    
    init(service: PexelService) {
        self.service = service
    }
    
    internal func initialLoad() async {
        guard items.isEmpty else { return }
        await reload()
    }
    
    internal func reload() async {
        isLoading = true
        defer {
            isLoading = false
        }
        await service.getPhotos(isInitialLoad: true)
        await syncFromService()
    }
    
    internal func loadMoreIfNeeded(currentItem: PexelPhoto?) async {
        guard let currentItem,
              let lastItem = items.last,
              currentItem.id == lastItem.id else {
            return
        }
        
        await service.getPhotos(isInitialLoad: false)
        await syncFromService()
    }
    
    // MARK: - Private methods
    private func syncFromService() async {
        self.items = await service.photos
        self.alertMessage = await service.dataLoadingError?.localizedDescription
    }
}
