//
//  HomepageViewModel.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 27/04/2023.
//

import Foundation
import UIKit

class HomepageViewModel {
    
    var articlesToDisplay: [Article] = []
    var totalResultsPages = 1
     
    func getTopArticlesFromAPI(pageNumber: Int, completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        AppConstants.articlesRepository.getLatestArticles(pageNumber: pageNumber) { articles, totalPages,  errorMsg in
            if (errorMsg != nil) {
                completionHandler(errorMsg)
            } else {
                self.articlesToDisplay = articles
                self.totalResultsPages = totalPages
                completionHandler(nil)
            }
        }
    }
    
    func articlesAmount() -> Int {
        return articlesToDisplay.count
    }
    
    func currentArticle(index: Int) -> Article {
        return articlesToDisplay[index]
    }

}



