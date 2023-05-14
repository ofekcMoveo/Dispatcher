//
//  SearchRepository.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 09/05/2023.
//

import Foundation

class SearchRepository {
    
    static let shared = SearchRepository()
    let userDefaultsManager = UserDefaultsManager()
    
    private init() {}
    
    func saveSearches(_ latestSearches: [RecentSearch]) throws {
        do {
            let data = try JSONEncoder().encode(latestSearches)
            userDefaultsManager.saveItem(itemToSave: data, itemToSaveKey: UserDefaultsKeys.latestSearchesDefualtsKey)
        }
    }
    
    func fetchLatestSearchs() throws -> [RecentSearch] {
        do {
            let data = userDefaultsManager.fetchDataFromUserDefaults(wantedItemKey: UserDefaultsKeys.latestSearchesDefualtsKey)
            return try JSONDecoder().decode([RecentSearch].self, from: data)
        }
    }
    
    func removeSearches() {
        userDefaultsManager.removeItem(itemToRemoveKey: UserDefaultsKeys.latestSearchesDefualtsKey)
    }
}
