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
                                .padding(.top, 32)
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
                        ScrollView(showsIndicators: false) {
                            MovieListView(title: String(localized: "now_playing"), movies: viewModel.nowPlayingMovies)
                            
                            MovieListView(title: String(localized: "popuplar_movies"), movies: viewModel.popularMovies)
                            
                            MovieListView(title: String(localized: "top_rated"), movies: viewModel.topRatedMovies)
                            
                            MovieListView(title: String(localized: "upcoming_movies"), movies: viewModel.upcomingMovies)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    private func MovieListView(title: String, movies: [Movie]) -> some View {
        VStack(spacing: 12) {
            HStack {
                Text(title)
                    .font(.title2)
                    .foregroundStyle(.text)
                    .padding(.top, 24)
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(movies, id: \.id) { movie in
                        MovieItemView(movie: movie) {}
                    }
                }
            }.frame(height: 320)
            
            Spacer()
        }.padding(.horizontal, 24)
    }
}

#Preview {
    HomeScreen()
}
