//
//  SplashViewModel.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Foundation

class SplashViewModel: BaseViewModel {
    @Published var goDashboard: Bool = false
    
    private var authService = AuthService()
    
    func authenticate() {
        authService.auth()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self?.showAlert(message: String(localized: "generic_error"))
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else {
                    self?.showAlert(message: String(localized: "generic_error"))
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.goDashboard = true
                }
            })
            .store(in: &cancellables)
    }
}
