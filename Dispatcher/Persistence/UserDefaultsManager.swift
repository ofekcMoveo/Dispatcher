//
//  UserDefaultsManager.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 07/05/2023.
//

import Foundation

struct UserDefaultsManager {
    static let defaults = UserDefaults.standard
    
    static func fetchLatestSearchs() throws -> [RecentSearch] {
        let data = defaults.data(forKey: AppConstants.latestSearchesDefualtsKey) ?? Data()
        do {
            let decodedSearches = try JSONDecoder().decode([RecentSearch].self, from: data)
            return decodedSearches
        }
    }

    static func saveSearches(_ latestSearches: [RecentSearch]) throws {
        do {
            let data = try JSONEncoder().encode(latestSearches)
            defaults.set(data, forKey: AppConstants.latestSearchesDefualtsKey)
        }
    }
    
    static func removeSearches() {
        defaults.removeObject(forKey: AppConstants.latestSearchesDefualtsKey)
    }
}
