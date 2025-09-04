//
//  PhotoMapper.swift
//  PexelNetworking
//
//  Created by Ilia Baudin on 28.08.2025.
//

import Foundation
import PexelDomain

struct PhotoMapper {
    func map(_ dto: PhotoDTO) -> PexelDomain.PexelPhoto {
        let id: String = {
            if dto.id.rounded() == dto.id {
                return String(Int64(dto.id))
            } else {
                return String(dto.id)
            }
        }()
        
        let hiResUrl = dto.src.large2x.isEmpty ? (dto.src.large.isEmpty ? nil : dto.src.large) : dto.src.large2x
        
        return PexelDomain.PexelPhoto(
            id: id,
            photoTitle: dto.alt,
            authorName: dto.photographer,
            photoUrl: dto.src.medium,
            hiResUrl: hiResUrl
        )
    }
    
    func map(_ dtos: [PhotoDTO]) -> [PexelDomain.PexelPhoto] {
        dtos.map(map)
    }
}
