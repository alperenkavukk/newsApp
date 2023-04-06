//
//  searchApi.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 6.04.2023.
//

import Foundation
import Foundation

// MARK: - Welcome
struct SearchNews: Codable {
    let status: String
    let totalResults: Int
    let results: [Result]
}

// MARK: - Article
struct Result: Codable {
    let source: kaynak
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String
}

// MARK: - Source
struct kaynak: Codable {
    let id: String?
    let name: String
}
