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
                        viewModel.performSearch(page: 1)
                    }
                    .padding(.horizontal, 16)
                    
                    if viewModel.isSearching {
                        if viewModel.searchResults.movies.isEmpty && !viewModel.isLoading {
                            Text("no_results_found")
                                .foregroundColor(.textColor)
                                .padding(.top, 32)
                        } else {
                            ScrollView {
                                LazyVStack {
                                    ForEach(viewModel.searchResults.movies) { movie in
                                        SearchableItemView(movie: movie) {
                                            print(movie.overview)
                                        }
                                        .onAppear {
                                            viewModel.loadMoreMoviesIfNeeded(currentItem: movie, category: .search)
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 4)
                                    }
                                    
                                    if viewModel.isLoading {
                                        ProgressView()
                                            .padding()
                                    }
                                }
                            }
                            .scrollDismissesKeyboard(.immediately)
                            .onAppear {
                                UITableView.appearance().showsVerticalScrollIndicator = false
                            }
                        }
                    } else {
                        ScrollView(showsIndicators: false) {
                            MovieListView(title: String(localized: "now_playing"), movies: viewModel.nowPlayingMovies.movies, category: .nowPlaying)
                            
                            MovieListView(title: String(localized: "popuplar_movies"), movies: viewModel.popularMovies.movies, category: .popular)
                            
                            MovieListView(title: String(localized: "top_rated"), movies: viewModel.topRatedMovies.movies, category: .topRated)
                            
                            MovieListView(title: String(localized: "upcoming_movies"), movies: viewModel.upcomingMovies.movies, category: .upcoming)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder
    private func MovieListView(title: String, movies: [Movie], category: MovieCategory) -> some View {
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
                            .onAppear {
                                viewModel.loadMoreMoviesIfNeeded(currentItem: movie, category: category)
                            }
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
