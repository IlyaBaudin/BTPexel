//
//  PhotosListView.swift
//  BTPexel
//
//  Created by Ilia Baudin on 22.09.2025.
//

import SwiftUI
import PexelDomain

struct PhotosListView: View {
    @StateObject var viewModel: PhotosListViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.items.isEmpty && viewModel.isLoading {
                    ProgressView()
                        .controlSize(.large)
                } else {
                    List(viewModel.items, id: \.id) { photo in
                        NavigationLink {
                            PhotoDetailView(viewModel: PhotoDetailViewModel(photo: photo, service: AppContainer.previewService()))
                        } label: {
                            PhotoRow(photo: photo)
                                .onAppear {
                                    Task {
                                        await viewModel.loadMoreIfNeeded(currentItem: photo)
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                    .navigationLinkIndicatorVisibility(.hidden)
                }
            }
            .navigationTitle("Pexel Photos")
            .task {
                await viewModel.initialLoad()
            }
            .refreshable {
                await viewModel.reload()
            }
            .alert("Loading error", isPresented: Binding(
                get: { viewModel.alertMessage != nil },
                set: { _ in viewModel.alertMessage = nil }
            )) {
                Button("OK", role: .cancel) {  }
            } message: {
                Text(viewModel.alertMessage ?? "")
            }
        }
    }
}

#Preview {
    PhotosListView(
        viewModel: PhotosListViewModel(
            service: AppContainer.previewService()
        )
    )
}
