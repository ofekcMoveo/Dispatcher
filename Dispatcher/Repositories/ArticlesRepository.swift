//
//  ArticlesRepository.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 30/04/2023.
//

import Foundation

class ArticlesRepository {

    let alamofireManager = AlamofireManager()
    var articles: [Article] = []
    
    func getData(completionHandler: @escaping (_ articles: [Article], _ errorMsg: String?) -> Void) {
        let request = Request(baseUrl: APIConstants.newscatcherURL, headers: ["x-api-key": APIConstants.APIkey], parameters: ["countries" : "IL"], method: .get)
        alamofireManager.sendRequest(request) { (result: Result<ArticleApiObject, Error>) in
            switch result {
            case .success(let dataResult):
                for article in dataResult.articles {
                    if(article.language == "en") {
                        let article = Article(
                            id: article.id,
                            title: article.title,
                            summary: article.summary,
                            author: article.author, topic: [article.topic],
                            imageURL: article.media,
                            language: article.language,
                            date: article.publishedDate
                        )
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









