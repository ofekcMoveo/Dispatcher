//
//  ArticleResponse.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 01/05/2023.
//

import Foundation

struct ArticleResponse: Decodable {
    let id: String
    let title: String
    let author: String
    let publishedDate: String
    let summary: String
    let topic: String
    let country: String
    let language: String?
    let authors: String
    let media: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case author
        case publishedDate = "published_date"
        case summary
        case topic
        case country
        case language
        case authors
        case media
    }
}
