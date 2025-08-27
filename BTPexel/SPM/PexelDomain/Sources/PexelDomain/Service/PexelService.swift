//
//  PexelService.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

import Foundation

public final actor PexelService {
    // State
    private(set) var items: [PexelPhoto] = []
    private(set) var lastError: Error?
    private let paginator: Paginator
    private let fetchCurated: FetchCuratedPhotos
    private let selector: SelectPhoto
    
    // Init
    public init(perPage: Int, repository: PhotosRepository) {
        self.paginator = Paginator(perPage: perPage)
        self.fetchCurated = FetchCuratedPhotos(repo: repository)
        self.selector = SelectPhoto()
    }
    
    // Read API
    public var photos: [PexelPhoto] { items }
    public var dataLoadingError: Error? { lastError }
    
    // Actions
    public func getPhotos(isInitialLoad: Bool) async {
        if isInitialLoad {
            await paginator.reset()
            items.removeAll()
            lastError = nil
        }
        guard let page = await paginator.nextPageIfPossible() else { return }
        do {
            let new = try await fetchCurated.execute(page: page, perPage: await paginator.perPage)
            if new.isEmpty { await paginator.markAsAllLoaded() }
            items.append(contentsOf: new)
        } catch {
            lastError = error
        }
    }
    
    public func selectPhoto(_ photo: PexelPhoto) async {
        await selector.select(photo)
    }
    
}
