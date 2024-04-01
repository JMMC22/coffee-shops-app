//
//  UserDefaultManager.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

class UserDefaultManager: NSObject {
    
    static let shared = UserDefaultManager()
    private let userDefaults: UserDefaults?
    
    private override  init() {
        self.userDefaults = UserDefaults.standard
    }
    
    func get<T>(for key: UserDefaultsKey) -> T? {
        let result = self.userDefaults?.object(forKey: key.value) as? T
        return result
    }

    func set<T>(_ obj: T, for key: UserDefaultsKey) {
        self.userDefaults?.set(object, forKey: key.value)
        self.userDefaults?.synchronize()
    }

    func remove(for key: UserDefaultsKey) {
        self.userDefaults?.removeObject(forKey: key.value)
        self.userDefaults?.synchronize()
    }

    func object(for key: UserDefaultsKey) -> Any? {
        let result = self.userDefaults?.object(forKey: key.value)
        return result
    }

    static func clean() {
        let keys = UserDefaultsKey.allCases
        keys.forEach {
            let excluded = UserDefaultsKey.excludedCases.contains($0)
            if excluded {
                print("Excluded case: \($0.value)")
            } else {
                UserDefaultManager.shared.remove(for: $0)
            }
        }
    }
}
