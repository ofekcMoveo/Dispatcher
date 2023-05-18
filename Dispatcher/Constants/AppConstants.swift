//
//  AppConstants.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 30/04/2023.
//

import Foundation

struct AppConstants {
    
    //MARK: Homepage articles table
    static let tableRowHight = 40
    
    //MARK: Search
    static let latestSearchesAmount = 10
}

struct TableCellsIdentifiers {
    static let articleCellIdentifier = "articleCell"
    static let latestSearchesCellIdentifier = "latestSearchCell"
}

struct NibNames {
    static let articleCellNibName = "ArticleCell"
    static let latestSearchCellNibName = "LatestSearchCell"
}

struct SegueIdentifiers {
    static let fromLatestSearchToResults = "fromLatestSearchToResults"
    static let fromSearchResultsToHomepage = "fromSearchResultsToHomepage"
}

struct UserDefaultsKeys {
    static let latestSearchesDefualtsKey = "LatestSearches"
}

