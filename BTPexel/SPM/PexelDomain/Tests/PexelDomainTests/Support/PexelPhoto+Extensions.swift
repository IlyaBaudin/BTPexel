//
//  PexelPhoto+Extensions.swift
//  PexelDomain
//
//  Created by Ilia Baudin on 22.09.2025.
//

import Foundation
@testable import PexelDomain

extension PexelPhoto {
    static internal func makePhoto(id: Int) -> PexelPhoto {
        PexelPhoto(
            id: "\(id)",
            photoTitle: "t_\(id)",
            authorName: "a_\(id)",
            photoUrl: "u_\(id)"
        )
    }
}
