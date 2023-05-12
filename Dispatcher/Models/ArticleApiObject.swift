//
//  ArticleAPIObject.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 01/05/2023.
//

import Foundation

struct ArticleApiObject : Decodable {
    let status: String
        let totalHits: Int
        let page: Int
        let totalPages: Int
        let pageSize: Int
        let articles: [ArticleResponse]
        let userInput: UserInput
        
        enum CodingKeys: String, CodingKey {
            case status
            case totalHits = "total_hits"
            case page
            case totalPages = "total_pages"
            case pageSize = "page_size"
            case articles
            case userInput = "user_input"
        }
}
