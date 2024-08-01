//
//  PexelDataModel.swift
//  PexelSDK
//
//  Created by Ilia Baudin on 31.07.2024.
//

import Foundation

/// Data model to manage values inside PexelCoreSDK and allow read values from UI using proxy properties
class PexelDataModel {
    var photos: [PexelPhotoProtocol] = []
    var photosLoadingError: Error? = nil
    var selectedPhoto: PexelPhotoProtocol? = nil
}
