//
//  HomepageViewModel.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 27/04/2023.
//

import Foundation

class HomepageViewModel {
    
    private let articlesRepository = ArticlesRepository()
    var articlesToDisplay: [Article] = []
     
    func getArticlesToDisplay(completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        articlesRepository.getArticlesFromApi { articles, errorMsg in
            if (errorMsg != nil) {
                completionHandler(errorMsg)
            } else {
                self.articlesToDisplay = articles
                completionHandler(nil)
            }
        }
    }
    
    func articlesAmount() -> Int {
        return articlesToDisplay.count
    }
    
    func getArticleByIndex(index: Int) -> Article {
        return articlesToDisplay[index]
    }

}



