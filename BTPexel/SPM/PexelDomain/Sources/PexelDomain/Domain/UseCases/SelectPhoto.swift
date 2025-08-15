//
//  SelectPhoto.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 13.08.2025.
//

public actor SelectPhoto {
    public private(set) var selected: PexelPhoto?
    
    public init() {
        
    }
    
    public func select(_ photo: PexelPhoto) {
        self.selected = photo
    }
}
