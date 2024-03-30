//
//  RequestError.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

enum RequestError: Error {
    case error(statusCode: Int, data: Data?)
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
}
