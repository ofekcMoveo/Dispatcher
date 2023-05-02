//
//  ArticleResponse.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 01/05/2023.
//

import Foundation

struct ArticleResponse: Decodable {
    let title: String
    let author: String
    let publishedDate: String
    let publishedDatePrecision: String
    let link: String
    let cleanUrl: String
    let excerpt: String?
    let summary: String
    let rights: String
    let rank: Int
    let topic: String
    let country: String
    let language: String?
    let authors: String
    let media: String
    let isOpinion: Bool
    let twitterAccount: String?
    let score: Double?
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case publishedDate = "published_date"
        case publishedDatePrecision = "published_date_precision"
        case link
        case cleanUrl = "clean_url"
        case excerpt
        case summary
        case rights
        case rank
        case topic
        case country
        case language
        case authors
        case media
        case isOpinion = "is_opinion"
        case twitterAccount = "twitter_account"
        case score = "_score"
        case id = "_id"
    }
}
