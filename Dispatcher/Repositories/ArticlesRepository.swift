//
//  ArticlesRepository.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 30/04/2023.
//

import Foundation

class ArticlesRepository {
    //TODO: maybe change to a singleton
    
    let alamofireManager = AlamofireManager()
    var articles: [Article] = []
    
    func getLatestArticles(pageNumber: Int, completionHandler: @escaping (_ articles: [Article], _ totalPages: Int, _ errorMsg: String?) -> Void) {
        self.articles = []
        let request = buildLatestArticlesRequest(pageNumber)
        
        alamofireManager.sendRequest(request) { (result: Result<ArticleApiObject, Error>) in
            switch result {
            case .success(let dataResult):
                for article in dataResult.articles {
                    if(article.language == "en") {
                        let article = Article(
                            id: article.id,
                            title: article.title,
                            summary: article.summary,
                            author: article.author,
                            topic: [article.topic],
                            imageURL: article.media,
                            language: article.language,
                            date: article.publishedDate)
                        self.articles.append(article)
                        completionHandler(self.articles, Int(dataResult.totalPages), nil)
                    }
                }
            case .failure(let error):
                completionHandler([], 0, error.localizedDescription)
            }
        }
    }
    
    private func buildLatestArticlesRequest(_ pageNumber: Int) -> Request {
        return Request(
            baseUrl: APIConstants.latestHeadlinesNewscatcherURL,
            headers: ["x-api-key": APIConstants.APIkey],
            parameters: ["countries" : "IL", "page_size": APIConstants.ARTICLES_TO_FETCH_AMOUNT, "page" : pageNumber],
            method: .get)
    }
    
    func getArticlesByKeywords(_ searchKeywords: String, pageNumber: Int, completionHandler: @escaping ( _ articles: [Article], _ totalPages: Int, _ errorMsg: String?) -> Void) {
        self.articles = []
        let request = buildSearchArticlesRequest(searchKeywords, pageNumber)
        
        alamofireManager.sendRequest(request) { (result: Result<ArticleApiObject, Error>) in
            switch result {
            case .success(let dataResult):
                for article in dataResult.articles {
                    if(article.language == "en") {
                        let article = Article(
                            id: article.id,
                            title: article.title,
                            summary: article.summary,
                            author: article.author,
                            topic: [article.topic],
                            imageURL: article.media,
                            language: article.language,
                            date: article.publishedDate)
                        self.articles.append(article)
                        completionHandler(self.articles, Int(dataResult.totalPages), nil)
                    }
                }
            case .failure(let error):
                completionHandler([], 0, error.localizedDescription)
            }
        }
    }
}
    
private func buildSearchArticlesRequest(_ searchKeywords: String, _ pageNumber: Int) -> Request {
    return Request(
        baseUrl: APIConstants.searchArticlesNewscatcherURL,
        headers: ["x-api-key": APIConstants.APIkey],
        parameters: ["q" : searchKeywords, "countries" : "IL", "page_size" : APIConstants.ARTICLES_TO_FETCH_AMOUNT , "page" : pageNumber],
        method: .get)
}




