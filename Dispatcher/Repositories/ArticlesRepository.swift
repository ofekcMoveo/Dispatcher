//
//  ArticlesRepository.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 30/04/2023.
//

import Foundation

class ArticlesRepository {
    
    static let shared = ArticlesRepository()
    let alamofireManager = AlamofireManager()
    
    private init() {}

    func getArticlesFromApi(searchKeywords: String?, pageNumber: Int, completionHandler: @escaping (_ articles: [Article], _ totalPages: Int, _ errorMsg: String?) -> Void) {
        let request = buildRequest(searchKeywords: searchKeywords, pageNumber: pageNumber)
        alamofireManager.sendRequest(request) { (result: Result<ArticleApiObject, Error>) in
            switch result {
            case .success(let dataResult):
                var articles: [Article] = []
                for article in dataResult.articles {
                    if(article.language == "en" || article.language == "he") {
                        articles.append(self.buildArticleFromArticleResponse(article))
                    }
                }
                completionHandler(articles, dataResult.totalPages, nil)
            case .failure(let error):
                completionHandler([], 0, error.localizedDescription)
            }
        }
    }

    private func buildRequest(searchKeywords: String? , pageNumber: Int) -> Request {
        if let searchKeywords {
            return Request(
                baseUrl: APIConstants.baseApiUrl,
                endpoint: APIConstants.searchEndpoint,
                parameters: ["q" : searchKeywords, "countries" : "IL", "page_size" : APIConstants.articlesPageSize , "page" : pageNumber],
                method: .get)
        } else {
            return Request(
                baseUrl: APIConstants.baseApiUrl,
                endpoint: APIConstants.latestHeadlinesEndpoint,
                parameters: ["countries" : "IL", "page_size": APIConstants.articlesPageSize, "page" : pageNumber],
                method: .get)
        }
        
    }

    private func buildArticleFromArticleResponse(_ apiAtricle :ArticleResponse) -> Article {
        let article = Article(
            id: apiAtricle.id,
            title: apiAtricle.title,
            summary: apiAtricle.summary,
            author: apiAtricle.author,
            topic: [apiAtricle.topic],
            imageURL: apiAtricle.media,
            language: apiAtricle.language,
            date: apiAtricle.publishedDate
        )
        
        return article
    }
}




