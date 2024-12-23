//
//  Moya+Extension.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Foundation
import Moya

extension Response {
    func decodeAPIError() throws -> APIError {
        return try JSONDecoder().decode(APIError.self, from: self.data)
    }
}
