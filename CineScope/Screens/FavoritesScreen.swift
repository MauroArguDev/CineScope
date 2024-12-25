//
//  FavoritesScreen.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 24/12/24.
//

import SwiftUI

struct FavoritesScreen: View {
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            Text("favorites")
                .foregroundStyle(Color.textColor)
        }
    }
}

#Preview {
    FavoritesScreen()
}
