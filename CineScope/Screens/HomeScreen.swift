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
                            VStack(spacing: 12) {
                                HStack {
                                    Text("Now Playing")
                                        .font(.title2)
                                        .foregroundStyle(.text)
                                        .padding(.top, 24)
                                    
                                    Spacer()
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 12) {
                                        ForEach(viewModel.nowPlayingMovies, id: \.id) { movie in
                                            MovieItemView(movie: movie) {}
                                        }
                                    }
                                }.frame(height: 320)
                                
                                Spacer()
                            }.padding(.horizontal, 24)
                            
                            VStack(spacing: 12) {
                                HStack {
                                    Text("Popular Movies")
                                        .font(.title2)
                                        .foregroundStyle(.text)
                                        .padding(.top, 24)
                                    
                                    Spacer()
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 12) {
                                        ForEach(viewModel.popularMovies, id: \.id) { movie in
                                            MovieItemView(movie: movie) {}
                                        }
                                    }
                                }.frame(height: 320)
                                
                                Spacer()
                            }.padding(.horizontal, 24)
                            
                            VStack(spacing: 12) {
                                HStack {
                                    Text("Top Rated")
                                        .font(.title2)
                                        .foregroundStyle(.text)
                                        .padding(.top, 24)
                                    
                                    Spacer()
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 12) {
                                        ForEach(viewModel.topRatedMovies, id: \.id) { movie in
                                            MovieItemView(movie: movie) {}
                                        }
                                    }
                                }.frame(height: 320)
                                
                                Spacer()
                            }.padding(.horizontal, 24)
                            
                            VStack(spacing: 12) {
                                HStack {
                                    Text("Upcoming Movies")
                                        .font(.title2)
                                        .foregroundStyle(.text)
                                        .padding(.top, 24)
                                    
                                    Spacer()
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 12) {
                                        ForEach(viewModel.upcomingMovies, id: \.id) { movie in
                                            MovieItemView(movie: movie) {}
                                        }
                                    }
                                }.frame(height: 320)
                                
                                Spacer()
                            }.padding(.horizontal, 24)
                        }
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
