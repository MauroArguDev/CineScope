//
//  BaseViewModel.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String?
    
    var cancellables: Set<AnyCancellable> = []
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
    func resetAlert() {
        alertMessage = nil
        showAlert = false
    }
    
    func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        if case let .failure(error) = completion {
            isLoading = false
            showAlert(message: error.localizedDescription)
        }
    }
}
