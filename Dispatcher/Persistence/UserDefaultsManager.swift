//
//  UserDefaultsManager.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 07/05/2023.
//

import Foundation

struct UserDefaultsManager {
    let defaults = UserDefaults.standard
    
    func fetchDataFromUserDefaults(wantedItemKey: String) -> Data {
        return defaults.data(forKey: wantedItemKey) ?? Data()
    }

    func saveItem(itemToSave: Data, itemToSaveKey: String) {
        defaults.set(itemToSave, forKey: itemToSaveKey)
    }
    
    func removeItem(itemToRemoveKey: String) {
        defaults.removeObject(forKey: itemToRemoveKey)
    }
}
