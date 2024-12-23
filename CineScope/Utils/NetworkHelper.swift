//
//  NetworkHelper.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Foundation
import Moya
import Combine

struct APIError: Codable, Error {
    let timestamp: String?
    let error: String?
    let description: String?
    let status: Int?
    let path: String?
    let errors: [ErrorDetail]?
}

struct ErrorDetail: Codable {
    let reason: String
}
