//
//  SearchScreenViewModelController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 02/05/2023.
//

import Foundation

class SearchViewModel {

    let searchRepository = SearchRepository()
    var articlesToDisplay: [Article] = []
    var latestSearches: [RecentSearch] = []
    var totalResultsPages = 1
    var isPaginating = false
    var currentPage = 1
    
    func getArticlesFromAPIBySearch(searchKeyWords: String, completionHandler: @escaping (_ errorMsg: String?, _ numberOfNewItems: Int) -> Void) {
        if (!isPaginating && currentPage <= totalResultsPages) {
            isPaginating = true
            ArticlesRepository.shared.getArticlesFromApi(searchKeywords: searchKeyWords, pageNumber: currentPage, completionHandler: { articles, totalPages, errorMsg in
                self.isPaginating = false
                if (errorMsg != nil) {
                    completionHandler(errorMsg, 0)
                } else {
                    self.articlesToDisplay = articles
                    self.totalResultsPages = totalPages
                    self.currentPage += 1
                    completionHandler(nil, articles.count)
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
        try latestSearches = searchRepository.fetchLatestSearchs()
        if(latestSearches.isEmpty == true) {
            throw Errors.userDefaultFetchFailedError
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
            try searchRepository.saveSearches(latestSearches)
        }
    }

    func removeSearch(_ currentSearch: String) throws {
        if let index = latestSearches.firstIndex(where: { recentSearch in
            recentSearch.searchKeyWords == currentSearch
        }) {
            latestSearches.remove(at: index)
            try searchRepository.saveSearches(latestSearches)
        }
    }

    func removeAllSearches() {
        searchRepository.removeSearches()
        latestSearches = []
    }
}
