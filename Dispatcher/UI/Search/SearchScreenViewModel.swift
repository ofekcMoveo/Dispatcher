//
//  SearchScreenViewModelController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 02/05/2023.
//

import Foundation

class SearchScreenViewModel {
    var articlesToDisplay: [Article] = []
    
    func getArticlesFromAPIBySearch(_ searchKeyWords: String, completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        AppConstants.articlesRepository.getArticlesByKeywords(searchKeyWords, completionHandler: { articles, errorMsg in
            if (errorMsg != nil) {
                completionHandler(errorMsg)
            } else {
                self.articlesToDisplay = articles
                completionHandler(nil)
            }
        })
    }
    
    func articlesAmount() -> Int {
        return articlesToDisplay.count
    }
    
    func currentArticle(index: Int) -> Article {
        return articlesToDisplay[index]
    }

}
