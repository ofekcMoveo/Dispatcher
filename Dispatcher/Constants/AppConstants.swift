//
//  AppConstants.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 30/04/2023.
//

import Foundation

struct AppConstants {
    //MARK: Global instanse of ArticlesRepository
    static let articlesRepository = ArticlesRepository()
    
    //MARK: Homepage articles table
    static let articleCellIdentifier = "articleCell"
    static let articleCellNibName = "ArticleCell"
    
    
    //MARK: Search screen table
    static let previousSearchesCellIdentifier = "previousSearchCell"
    static let previousSearchCellNibName = "PreviousSearchCell"
    static let LATEST_SEARCHES_AMOUNT = 10
    
    
    //MARK: segues
    static let fromPreviousSearchToResults = "fromPreviousSearchToResults"
    
    //MARK: No data error
    static let noArticlesFoundError = "Response could not be decoded because of error:\nThe data couldn’t be read because it is missing."
}
