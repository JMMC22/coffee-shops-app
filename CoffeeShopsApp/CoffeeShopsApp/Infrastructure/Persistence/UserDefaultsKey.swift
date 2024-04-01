//
//  UserDefaultsKey.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

enum UserDefaultsKey: String, CaseIterable {

    case favouritesCoffeeShops = "favouritesCoffeeShops"

    static var excludedCases: [UserDefaultsKey] = []

    var value : String {
        return self.rawValue
    }
    
}
