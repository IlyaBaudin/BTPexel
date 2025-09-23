//
//  BTPexelApp.swift
//  BTPexel
//
//  Created by Ilia Baudin on 22.09.2025.
//
import SwiftUI


@main
struct BTPexelApp: App {
    
    @StateObject private var container = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            PhotosListView(viewModel: PhotosListViewModel(service: container.service))
        }
    }
}
