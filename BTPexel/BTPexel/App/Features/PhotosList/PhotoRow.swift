//
//  PhotoRow.swift
//  BTPexel
//
//  Created by Ilia Baudin on 22.09.2025.
//

import SwiftUI
import PexelDomain

struct PhotoRow: View {
    let photo: PexelPhoto
    
    var body: some View {
        ShadowCard {
            HStack(spacing: 12) {
                AsyncImage(url: URL(string: photo.photoUrl)) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.1)
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        Color.gray.opacity(0.2)
                    @unknown default:
                        Color.gray.opacity(0.2)
                    }
                }
                .frame(width: 96, height: 96)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 8).stroke(Color.black.opacity(0.05))
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(photo.photoTitle.isEmpty ? "Untitled" : photo.photoTitle)
                        .font(.headline)
                        .lineLimit(2)
                    Text(photo.authorName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

#Preview {
    PhotoRow(photo: PexelPhoto(id: "1", photoTitle: "Title", authorName: "Authour", photoUrl: ""))
}
