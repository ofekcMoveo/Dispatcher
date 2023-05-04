//
//  SearchScreenViewModelController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 02/05/2023.
//

import Foundation

class SearchViewModel {
    var articlesToDisplay: [Article] = []
    var latestSearches: [String] = []
    var totalResultsPages = 1
    var isPaginating = false
    
    func getArticlesFromAPIBySearch(_ searchKeyWords: String, pageNumber: Int, completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        if (isPaginating == false) {
            isPaginating = true
            AppConstants.articlesRepository.getArticlesByKeywords(searchKeyWords, pageNumber: pageNumber, completionHandler: { articles, totalPages, errorMsg in
                if (errorMsg != nil) {
                    completionHandler(errorMsg)
                } else {
                    self.articlesToDisplay = articles
                    self.totalResultsPages = totalPages
                    self.isPaginating = false
                    completionHandler(nil)
                }
            })
        }
    }
    
    func articlesAmount() -> Int {
        return articlesToDisplay.count
    }
    
    func currentArticle(index: Int) -> Article {
        return articlesToDisplay[index]
    }
    
    func fetchLatestSearchs() {
        latestSearches = (AppConstants.defaults.array(forKey: AppConstants.latestSearchesDefualtsKey) as? [String]) ?? []
    }

    func addNewSearch(_ currentSearch: String) {
        if let index = latestSearches.firstIndex(of: currentSearch) {
            latestSearches.remove(at: index)
        } else if (latestSearches.count == AppConstants.LATEST_SEARCHES_AMOUNT) {
            latestSearches.removeFirst()
        }

        latestSearches.append(currentSearch)
        AppConstants.defaults.set(latestSearches, forKey: AppConstants.latestSearchesDefualtsKey)
    }

    func removeSearch(_ currentSearch: String) {
        if let index = latestSearches.firstIndex(of: currentSearch) {
            latestSearches.remove(at: index)
            AppConstants.defaults.set(latestSearches, forKey: AppConstants.latestSearchesDefualtsKey)
        }
    }

    func removeAllSearches() {
        AppConstants.defaults.removeObject(forKey: AppConstants.latestSearchesDefualtsKey)
        latestSearches = []
    }
}
