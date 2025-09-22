//
//  SelectPhoto.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

/// Use case that allow user to select a photo for detailed representation
public actor SelectPhoto {
    // MARK: - Private properties
    public private(set) var selected: PexelPhoto?
    
    // MARK: - Init
    public init() { }
    
    // MARK: - Public methods
    public func select(_ photo: PexelPhoto) {
        self.selected = photo
    }
    
    public func clear() {
        self.selected = nil
    }
}
