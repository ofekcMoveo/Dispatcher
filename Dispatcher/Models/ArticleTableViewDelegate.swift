//
//  ArticleCellDelegate.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 20/04/2023.
//

import Foundation

protocol ArticleTableViewDelegate {
    func navigateToArticle(_ articleTitle: String)
    func addArticleToFavorites(_ articleTitle: String)
    
}
