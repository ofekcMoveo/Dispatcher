//
//  HomepageViewModel.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 27/04/2023.
//

import Foundation
import UIKit

class HomepageViewModel {
    
    private let articlesRepository = ArticlesRepository()
    var articlesToDisplay: [Article] = []
     
    func getArticlesFromAPI(completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        articlesRepository.getData { articles, errorMsg in
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
    
    func currentArticle(index: Int) -> Article {
        return articlesToDisplay[index]
    }

}



