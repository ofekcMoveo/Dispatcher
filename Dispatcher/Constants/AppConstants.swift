//
//  AppConstants.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 30/04/2023.
//

import Foundation

struct AppConstants {

    //MARK: Global instanses
    static let articlesRepository = ArticlesRepository()
    static let defaults = UserDefaults.standard
    
    //MARK: Homepage articles table
    static let TABLE_ROW_HEIGHT = 40
    
    //MARK: Search
    static let LATEST_SEARCHES_AMOUNT = 10
    static let latestSearchesDefualtsKey = "LatestSearches"
    
    //MARK: segues
    static let fromLatestSearchToResults = "fromLatestSearchToResults"
    
    //MARK: No data error
    static let noArticlesFoundError = "Response could not be decoded because of error:\nThe data couldn’t be read because it is missing."
    
}

struct TableCellsIdentifiers {
    static let articleCellIdentifier = "articleCell"
    static let latestSearchesCellIdentifier = "latestSearchCell"
    
}

struct NibNames {
    static let articleCellNibName = "ArticleCell"
    static let latestSearchCellNibName = "LatestSearchCell"

    
}
