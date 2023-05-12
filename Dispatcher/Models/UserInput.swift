//
//  UserInput.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 01/05/2023.
//

import Foundation

struct UserInput: Decodable {
    let lang: String?
    let notLang: String?
    let countries: [String]?
    let notCountries: [String]?
    let page: Int
    let size: Int
    let sources: [String]?
    let notSources: [String]?
    let topic: String?
    let from: String
    
    enum CodingKeys: String, CodingKey {
        case lang
        case notLang = "not_lang"
        case countries
        case notCountries = "not_countries"
        case page
        case size
        case sources
        case notSources = "not_sources"
        case topic
        case from
    }
}
