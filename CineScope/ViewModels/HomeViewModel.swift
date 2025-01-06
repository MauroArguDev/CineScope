//
//  HomeViewModel.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 24/12/24.
//

import Foundation

class HomeViewModel: BaseViewModel {
    @Published var searchQuery: String = ""
    @Published var searchResults = PaginatedMovies()
    @Published var nowPlayingMovies = PaginatedMovies()
    @Published var popularMovies = PaginatedMovies()
    @Published var topRatedMovies = PaginatedMovies()
    @Published var upcomingMovies = PaginatedMovies()
    
    @Published var isLoadingMore = false
    @Published var isSearching = false
    
    private let movieService = MovieService()
    
    override init() {
        super.init()
        resetMovies()
        setupSearchSubscription()
        fetchMovies()
    }
    
    private func setupSearchSubscription() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                if query.isEmpty {
                    self?.isSearching = false
                    self?.searchResults = PaginatedMovies()
                } else {
                    self?.isSearching = true
                    self?.performSearch(page: 1)
                }
            }
            .store(in: &cancellables)
    }
    
    private func resetMovies() {
        searchResults = PaginatedMovies()
        nowPlayingMovies = PaginatedMovies()
        popularMovies = PaginatedMovies()
        topRatedMovies = PaginatedMovies()
        upcomingMovies = PaginatedMovies()
    }
    
    private func fetchMovies() {
        fetchNowPlayingMovies(page: 1)
        fetchPopularMovies(page: 1)
        fetchTopRatedMovies(page: 1)
        fetchUpcomingMovies(page: 1)
    }
    
    func loadMoreMoviesIfNeeded(currentItem: Movie, category: MovieCategory) {
        let paginatedResults = getMoviesByCategory(category: category)
        guard let lastItem = paginatedResults.movies.last else { return }

        if currentItem.id == lastItem.id && paginatedResults.currentPage < paginatedResults.totalPages {
            loadNextPage(page: paginatedResults.currentPage + 1, category: category)
        }
    }
    
    private func getMoviesByCategory(category: MovieCategory) -> PaginatedMovies {
        switch category {
        case .search: return searchResults
        case .nowPlaying: return nowPlayingMovies
        case .popular: return popularMovies
        case .topRated: return topRatedMovies
        case .upcoming: return upcomingMovies
        }
    }
    
    private func loadNextPage(page: Int, category: MovieCategory) {
        switch category {
        case .search: performSearch(page: page)
        case .nowPlaying: fetchNowPlayingMovies(page: page)
        case .popular: fetchPopularMovies(page: page)
        case .topRated: fetchTopRatedMovies(page: page)
        case .upcoming: fetchUpcomingMovies(page: page)
        }
    }
    
    func performSearch(page: Int) {
        guard !searchQuery.isEmpty else { return }
        if page > searchResults.totalPages { return }
        
        movieService.searchMovies(includeAdult: true, query: searchQuery, page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                guard let response = response else {
                    self?.showAlert(message: "generic_error")
                    return
                }
                self?.searchResults.movies.append(contentsOf: response.results)
                self?.searchResults.currentPage = response.page
                self?.searchResults.totalPages = response.totalPages
            }.store(in: &cancellables)
    }
    
    func fetchNowPlayingMovies(page: Int) {
        if page > nowPlayingMovies.totalPages { return }
        
        movieService.getNowPlayingMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                guard let response = response else {
                    self?.showAlert(message: "generic_error")
                    return
                }
                self?.nowPlayingMovies.movies.append(contentsOf: response.results)
                self?.nowPlayingMovies.currentPage = response.page
                self?.nowPlayingMovies.totalPages = response.totalPages
            }.store(in: &cancellables)
    }
    
    func fetchPopularMovies(page: Int) {
        if page > popularMovies.totalPages { return }
        
        movieService.getPopularMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                guard let response = response else {
                    self?.showAlert(message: "generic_error")
                    return
                }
                self?.popularMovies.movies.append(contentsOf: response.results)
                self?.popularMovies.currentPage = response.page
                self?.popularMovies.totalPages = response.totalPages
            }.store(in: &cancellables)
    }
    
    func fetchTopRatedMovies(page: Int) {
        if page > topRatedMovies.totalPages { return }
        
        movieService.getTopRatedMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                guard let response = response else {
                    self?.showAlert(message: "generic_error")
                    return
                }
                self?.topRatedMovies.movies.append(contentsOf: response.results)
                self?.topRatedMovies.currentPage = response.page
                self?.topRatedMovies.totalPages = response.totalPages
            }.store(in: &cancellables)
    }
    
    func fetchUpcomingMovies(page: Int) {
        if page > upcomingMovies.totalPages { return }
        
        movieService.getUpcomingMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                guard let response = response else {
                    self?.showAlert(message: "generic_error")
                    return
                }
                self?.upcomingMovies.movies.append(contentsOf: response.results)
                self?.upcomingMovies.currentPage = response.page
                self?.upcomingMovies.totalPages = response.totalPages
            }.store(in: &cancellables)
    }
}
