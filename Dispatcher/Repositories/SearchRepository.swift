//
//  SearchRepository.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 09/05/2023.
//

import Foundation

class SearchRepository {
    
    let userDefaultsManager = UserDefaultsManager()
    
    func saveSearches(_ latestSearches: [RecentSearch]) throws {
        do {
            let data = try JSONEncoder().encode(latestSearches)
            userDefaultsManager.saveSearches(data)
        }
    }
    
    func fetchLatestSearchs() throws -> [RecentSearch] {
        do {
            let data = userDefaultsManager.fetchDataFromUserDefaults()
            return try JSONDecoder().decode([RecentSearch].self, from: data)
        }
    }
    
    func removeSearches() {
        userDefaultsManager.removeSearches()
    }
}
