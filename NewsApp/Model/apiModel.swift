//
//  apiModel.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 3.04.2023.
//

import Foundation

// MARK: - Welcome
struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
/*struct Article: Codable {
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String
}*/
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: ID?
    let name: String
}

enum ID: String, Codable {
    case arsTechnica = "ars-technica"
    case bbcNews = "bbc-news"
    case cnn = "cnn"
    case engadget = "engadget"
    case googleNews = "google-news"
    case theVerge = "the-verge"
    case wired = "wired"
}
