//
//  PexelCoreSDK.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 26.07.2024.
//

import Foundation

public class PexelCoreSDK {
    
    // MARK: - Private properties
    private let backend: any BackendServiceProtocol
    private let paginator: PexelPaginator
    private let dataModel: PexelDataModel
    
    // MARK: - Read-only properties
    /// Downloaded photos objects
    public var photos: [PexelPhotoProtocol] {
        dataModel.photos
    }
    
    /// Error happened during photos loading
    public var dataLoadingError: Error? {
        dataModel.photosLoadingError
    }
    /// Selected by user photo object for detail view
    public var selectedPhoto: PexelPhotoProtocol? {
        dataModel.selectedPhoto
    }
    
    // MARK: - Init
    /// Basic initializer to create SDK object
    /// - Parameter backend: object conforms to `BackendServiceProtocol`
    internal init(backend: any BackendServiceProtocol) {
        self.backend = backend
        self.dataModel = PexelDataModel()
        self.paginator = PexelPaginator(perPage: 10)
    }
    
    /// Default public initializer that create SDK object with default configuration
    public convenience init() {
        let httpEndpoint = HttpEndpoint(domain: PexelSDKConstants.pexelProductionDomain)
        let requestComposer = UrlRequestComposer(httpEndpoint: httpEndpoint)
        let networkService = HTTPRestService(requestComposer: requestComposer)
        let requestAdapter = UrlBasicAuthRequestAdapter(token: PexelSDKConstants.pexelAPIKey)
        networkService.requestAdapter = requestAdapter
        self.init(backend: PexelBackend(networkService: networkService))
    }
    
    // MARK: - Public methods
    /// Fetch photo objects from backend
    /// - Parameters:
    ///   - isInitialLoad: initial photos loading OR user want to fetch next portion of data
    ///   - completion: callback `Result<[PexelPhotoProtocol], Error>`
    public func getPhotos(isInitialLoad: Bool, completion: @escaping((Result<[PexelPhotoProtocol], Error>) -> Void)) {
        
        // reset previous error
        dataModel.photosLoadingError = nil
        
        // reset pagination and loaded data for reload/first load
        if isInitialLoad {
            resetPagination()
        }
        
        // stop loading next portion of data if all data has been loaded
        guard !paginator.allDataLoaded else {
            completion(.success(dataModel.photos))
            return
        }
        
        // perform request execution
        let route = PexelAPIRouter.curatedPhotos(page: paginator.page, perPage: paginator.perPage)
        
        backend.fetchData(request: route) { (result: Result<PexelCuratedResponse, Error>) in
            switch result {
            case .success(let success):
                self.dataModel.photos.append(contentsOf: success.photos)
                self.paginator.increment(loadingFinished: success.photos.isEmpty)
                completion(.success(success.photos))
            case .failure(let failure):
                self.dataModel.photosLoadingError = failure
                completion(.failure(failure))
            }
        }
    }
    
    /// Select photo object for detailed view
    /// - Parameter photo: `PexelPhotoProtocol` item or nil for deselection
    public func selectPhoto(photo: PexelPhotoProtocol?) {
        dataModel.selectedPhoto = photo
    }
    
    // MARK: - Private methods
    /// Reset pagination and remove already loaded photo objects
    private func resetPagination() {
        paginator.resetPagination()
        dataModel.photos.removeAll()
        dataModel.selectedPhoto = nil
    }
}
