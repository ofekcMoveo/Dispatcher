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
     
    func getArticlesToDisplay(completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        if(isPaginating == false && currentPage <= totalResultsPages) {
            isPaginating = true
            ArticlesRepository.shared.getArticlesFromApi(pageNumber: currentPage) { articles, totalPages,  errorMsg in
                if (errorMsg != nil) {
                    completionHandler(errorMsg!)
                } else {
                    self.articlesToDisplay.append(contentsOf: articles)
                    self.totalResultsPages = totalPages
                    self.currentPage += 1
                    self.isPaginating = false
                    completionHandler(nil)
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



