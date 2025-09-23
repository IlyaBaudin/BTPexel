//
//  ShadowCard.swift
//  BTPexel
//
//  Created by Ilia Baudin on 23.09.2025.
//

import SwiftUI

struct ShadowCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white) // фон ячейки
            )
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.3),
                    radius: 5, x: 0, y: 1)
    }
}
