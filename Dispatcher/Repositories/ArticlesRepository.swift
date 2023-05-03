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
    
    func getLatestArticles(completionHandler: @escaping (_ articles: [Article], _ errorMsg: String?) -> Void) {
        let request = buildLatestArticlesRequest()
        
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
                        completionHandler(self.articles, nil)
                    }
                }
            case .failure(let error):
                completionHandler([], error.localizedDescription)
            }
        }
    }
    
    private func buildLatestArticlesRequest() -> Request {
        return Request(
            baseUrl: APIConstants.latestHeadlinesNewscatcherURL,
            headers: ["x-api-key": APIConstants.APIkey],
            parameters: ["countries" : "IL", "lang" : "en"],
            method: .get)
    }
    
    func getArticlesByKeywords(_ searchKeywords: String, completionHandler: @escaping ( _ articles: [Article], _ errorMsg: String?) -> Void) {
        let request = buildSearchArticlesRequest(searchKeywords)
        
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
                        completionHandler(self.articles, nil)
                    }
                }
            case .failure(let error):
                completionHandler([], error.localizedDescription)
            }
        }
    }
}
    
private func buildSearchArticlesRequest(_ searchKeywords: String) -> Request {
    return Request(
        baseUrl: APIConstants.searchArticlesNewscatcherURL,
        headers: ["x-api-key": APIConstants.APIkey],
        parameters: ["q" : searchKeywords, "countries" : "IL"],
        method: .get)
}




