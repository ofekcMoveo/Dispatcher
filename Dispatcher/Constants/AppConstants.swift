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
    
    //MARK: Homepage articles table
    static let tableRowHight = 40
    static let topHeadlinesHeaderText = "Top Headlines in Israel"
    
    //MARK: Search
    static let latestSearchesAmount = 10
    static let latestSearchesDefualtsKey = "LatestSearches"
    
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

struct SegueIdentifiers {
    static let fromLatestSearchToResults = "fromLatestSearchToResults"
}

