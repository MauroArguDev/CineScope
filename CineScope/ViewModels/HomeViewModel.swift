//
//  HomeViewModel.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 24/12/24.
//

import Foundation

class HomeViewModel: BaseViewModel {
    @Published var searchQuery: String = ""
    @Published var searchResults: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    
    @Published var isLoadingMore = false
    @Published var isSearching = false
    
    private let movieService = MovieService()
    
    override init() {
        super.init()
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
                    self?.searchResults = []
                } else {
                    self?.isSearching = true
                    self?.performSearch()
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchMovies() {
        fetchNowPlayingMovies(page: 1)
        fetchPopularMovies(page: 1)
        fetchTopRatedMovies(page: 1)
        fetchUpcomingMovies(page: 1)
    }
    
    func performSearch() {
        guard !searchQuery.isEmpty else { return }
        isLoading = true
        movieService.searchMovies(includeAdult: true, query: searchQuery, page: 1)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                self?.isLoading = false
                guard let response = response else {
                    self?.showAlert(message: "generic_error")
                    return
                }
                self?.searchResults = response.results
            }.store(in: &cancellables)
    }
    
    func fetchNowPlayingMovies(page: Int) {
        movieService.getNowPlayingMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                guard let response = response else {
                    self?.showAlert(message: "generic_error")
                    return
                }
                self?.nowPlayingMovies = response.results
            }.store(in: &cancellables)
    }
    
    func fetchPopularMovies(page: Int) {
        movieService.getPopularMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                guard let response = response else {
                    self?.showAlert(message: "generic_error")
                    return
                }
                self?.popularMovies = response.results
            }.store(in: &cancellables)
    }
    
    func fetchTopRatedMovies(page: Int) {
        movieService.getTopRatedMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                guard let response = response else {
                    self?.showAlert(message: "generic_error")
                    return
                }
                self?.topRatedMovies = response.results
            }.store(in: &cancellables)
    }
    
    func fetchUpcomingMovies(page: Int) {
        movieService.getUpcomingMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                guard let response = response else {
                    self?.showAlert(message: "generic_error")
                    return
                }
                self?.upcomingMovies = response.results
            }.store(in: &cancellables)
    }
}
