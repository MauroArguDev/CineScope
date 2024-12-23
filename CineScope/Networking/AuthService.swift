//
//  AuthService.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Moya

protocol AuthServiceProtocol {
    func auth() -> VoidPublisher
}

class AuthService: BaseService, AuthServiceProtocol {
    func auth() -> VoidPublisher {
        provider.requestPublisher(.authentication)
            .tryMap { response in
                guard response.statusCode < 300 else {
                    throw try response.decodeAPIError()
                }
                return response.data
            }
            .map { _ in () }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
