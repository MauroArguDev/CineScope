//
//  Combine+Extension.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Foundation
import Combine

extension Publisher {
    func mapToAPIError() -> Publishers.MapError<Self, Error> {
        return self.mapError { error -> Error in
            if let apiError = error as? APIError {
                return apiError
            } else {
                return error
            }
        }
    }
}
