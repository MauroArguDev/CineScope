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
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                
                VStack {
                    SearchBar(text: $viewModel.searchQuery) {
                        viewModel.performSearch()
                    }
                    .padding(.horizontal, 16)
                    
                    if viewModel.isSearching {
                        if viewModel.searchResults.isEmpty && !viewModel.isLoading {
                            Text("no_results_found")
                                .foregroundColor(.textColor)
                                .padding(.top, 32 )
                        } else {
                            List(viewModel.searchResults) { movie in
                                SearchableItemView(movie: movie) {
                                    print(movie.overview)
                                }
                            }
                            .listStyle(.plain)
                            .scrollIndicators(.hidden)
                        }
                    } else {
                        Text("explore_movies")
                            .font(.subheadline)
                            .foregroundColor(.textColor)
                            .padding()
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HomeScreen()
}
