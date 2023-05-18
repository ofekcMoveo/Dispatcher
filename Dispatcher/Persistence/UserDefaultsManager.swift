//
//  UserDefaultsManager.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 07/05/2023.
//

import Foundation

struct UserDefaultsManager {
    let defaults = UserDefaults.standard
    
    func fetchDataFromUserDefaults() -> Data {
        return defaults.data(forKey: AppConstants.latestSearchesDefualtsKey) ?? Data()
    }

    func saveSearches(_ encodedLatestSearches: Data) {
        defaults.set(encodedLatestSearches, forKey: AppConstants.latestSearchesDefualtsKey)
    }
    
    func removeSearches() {
        defaults.removeObject(forKey: AppConstants.latestSearchesDefualtsKey)
    }
}
