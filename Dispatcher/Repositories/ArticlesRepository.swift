//
//  ArticlesRepository.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 30/04/2023.
//

import Foundation

class ArticlesRepository {

    let alamofireManager = AlamofireManager()
    
    func getArticlesFromApi(completionHandler: @escaping (_ articles: [Article], _ errorMsg: String?) -> Void) {
        let request = Request(baseUrl: APIConstants.newscatcherURL, parameters: ["countries" : "IL"], method: .get)
        alamofireManager.sendRequest(request) { (result: Result<ArticleApiObject, Error>) in
            switch result {
            case .success(let dataResult):
                var articles: [Article] = []
                for article in dataResult.articles {
                    if(article.language == "en") {
                        articles.append(self.buildArticleFromArticleResponse(article))
                        completionHandler(articles, nil)
                    }
                }
            case .failure(let error):
                completionHandler([], error.localizedDescription)
            }
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









