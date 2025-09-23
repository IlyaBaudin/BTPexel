//
//  PhotoDetailView.swift
//  BTPexel
//
//  Created by Ilia Baudin on 22.09.2025.
//

import SwiftUI
import PexelDomain

struct PhotoDetailView: View {
    
    @StateObject var viewModel: PhotoDetailViewModel
    @State private var showHiRes: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ZStack {
                    AsyncImage(url: viewModel.previewUrl) { phase in
                        switch phase {
                        case .empty:
                            Rectangle().fill(Color.gray.opacity(0.1)).aspectRatio(1, contentMode: .fit)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .transition(.opacity)
                        case .failure:
                            Rectangle().fill(Color.gray.opacity(0.2)).aspectRatio(1, contentMode: .fit)
                        @unknown default:
                            Rectangle().fill(Color.gray.opacity(0.2)).aspectRatio(1, contentMode: .fit)
                        }
                    }
                    
                    if let data = viewModel.hiResImageData, let ui = UIImage(data: data) {
                        Image(uiImage: ui)
                            .resizable()
                            .scaledToFit()
                            .transition(.opacity.combined(with: .scale(scale: 1.01)))
                            .onAppear { withAnimation(.easeInOut(duration: 0.2)) { showHiRes = true } }
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.titleText.isEmpty ? "Untitled" : viewModel.titleText)
                        .font(.title2)
                        .bold()
                    Text(viewModel.authorText)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
        }
        .navigationTitle("Photo")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadHiResImageIfPossible()
        }
        .onDisappear {
            viewModel.clearSelection()
        }
    }
}

#Preview {
    PhotoDetailView(
        viewModel: PhotoDetailViewModel(
            photo: PexelPhoto(
                id: "1",
                photoTitle: "1",
                authorName: "1",
                photoUrl: ""
            ),
            service: AppContainer.previewService()
        )
    )
}
