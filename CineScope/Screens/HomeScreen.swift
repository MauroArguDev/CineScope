//
//  HomeScreen.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 24/12/24.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchQuery) {
                    viewModel.performSearch()
                }
                .padding(.horizontal, 16)
                
                if viewModel.isSearching {
                    if viewModel.searchResults.isEmpty {
                        Text("no_results_found")
                            .foregroundColor(.textColor)
                            .padding(.top, 32 )
                    } else {
                        List(viewModel.searchResults) { movie in
                            Text(movie.title)
                        }
                        .listStyle(PlainListStyle())
                    }
                } else {
                    Text("explore_movies")
                        .font(.subheadline)
                        .foregroundColor(.textColor)
                        .padding()
                }
                
                Spacer()
            }
            .searchable(text: $viewModel.searchQuery, prompt: "search")
            .onChange(of: viewModel.searchQuery) { _ in
                viewModel.performSearch()
            }
        }.background(Color.backgroundColor)
    }
}

#Preview {
    HomeScreen()
}
