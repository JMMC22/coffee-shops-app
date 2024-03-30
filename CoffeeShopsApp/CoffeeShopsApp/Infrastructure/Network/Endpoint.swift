//
//  Endpoint.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethodType { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryParameters: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
}
