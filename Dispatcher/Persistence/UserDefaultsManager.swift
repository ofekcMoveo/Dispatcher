//
//  UserDefaultsManager.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 07/05/2023.
//

import Foundation

struct UserDefaultsManager {
    static let defaults = UserDefaults.standard
    
    static func fetchLatestSearchs() -> [String] {
        return (defaults.array(forKey: AppConstants.latestSearchesDefualtsKey) as? [String]) ?? []
    }

    static func saveSearches(_ latestSearches: [String]) {
        defaults.set(latestSearches, forKey: AppConstants.latestSearchesDefualtsKey)
    }
    
    static func removeSearches() {
        defaults.removeObject(forKey: AppConstants.latestSearchesDefualtsKey)
    }
}
