//
//  SearchScreenViewModelController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 02/05/2023.
//

import Foundation

class SearchViewModel {
    var articlesToDisplay: [Article] = []
    var latestSearches: [RecentSearch] = []
    var totalResultsPages = 1
    var isPaginating = false
    var currentPage = 1
    
    func getArticlesFromAPIBySearch(_ searchKeyWords: String, completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        if (isPaginating == false && currentPage <= totalResultsPages) {
            isPaginating = true
            ArticlesRepository.shared.getArticlesByUserSearchWords(searchKeyWords, pageNumber: currentPage, completionHandler: { articles, totalPages, errorMsg in
                if (errorMsg != nil) {
                    completionHandler(errorMsg)
                } else {
                    self.articlesToDisplay = articles
                    self.totalResultsPages = totalPages
                    self.currentPage += 1
                    self.isPaginating = false
                    completionHandler(nil)
                }
            })
        }
    }
    
    func articlesAmount() -> Int {
        return articlesToDisplay.count
    }
    
    func getArticleByIndex(index: Int) -> Article {
        return articlesToDisplay[index]
    }
    
    func fetchLatestSearchs() throws {
        try latestSearches = SearchRepository.shared.fetchLatestSearchs()
        if(latestSearches.isEmpty == true) {
            throw AppConstants.userDefaultFetchFailedError
        }
    }

    func addNewSearch(_ currentSearch: String) throws {
        if let index = latestSearches.firstIndex(where: { recentSearch in
            recentSearch.searchKeyWords == currentSearch
        }) {
            latestSearches.remove(at: index)
        } else if (latestSearches.count == AppConstants.latestSearchesAmount) {
            latestSearches.removeFirst()
        }

        latestSearches.append(RecentSearch(searchKeyWords: currentSearch))
        do {
            try SearchRepository.shared.saveSearches(latestSearches)
        }
    }

    func removeSearch(_ currentSearch: String) throws {
        if let index = latestSearches.firstIndex(where: { recentSearch in
            recentSearch.searchKeyWords == currentSearch
        }) {
            latestSearches.remove(at: index)
            try SearchRepository.shared.saveSearches(latestSearches)
        }
    }

    func removeAllSearches() {
        SearchRepository.shared.removeSearches()
        latestSearches = []
    }
}
