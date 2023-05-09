//
//  RecentSearch.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 09/05/2023.
//

import Foundation

struct RecentSearch: Codable {
    let searchKeyWords: String
    
    init(searchKeyWords: String) {
        self.searchKeyWords = searchKeyWords
    }
}
