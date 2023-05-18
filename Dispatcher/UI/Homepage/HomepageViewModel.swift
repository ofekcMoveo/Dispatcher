//
//  HomepageViewModel.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 27/04/2023.
//

import Foundation
import UIKit

class HomepageViewModel {
    
    static let shared = HomepageViewModel()
    
    var articlesToDisplay: [Article] = []
    var totalResultsPages = 1
    var currentPage = 1
    var isPaginating = false
    
    private init () {}
     
    func getArticlesToDisplay(completionHandler: @escaping (_ errorMsg: String?, _ numberOfNewItems: Int) -> Void) {
        if(!isPaginating && currentPage <= totalResultsPages) {
            isPaginating = true
            ArticlesRepository.shared.getArticlesFromApi(searchKeywords: nil, pageNumber: currentPage) { articles, totalPages,  errorMsg in
                self.isPaginating = false
                if (errorMsg != nil) {
                    completionHandler(errorMsg!, 0)
                } else {
                    self.articlesToDisplay.append(contentsOf: articles)
                    self.totalResultsPages = totalPages
                    self.currentPage += 1
                    completionHandler(nil, articles.count)
                }
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



