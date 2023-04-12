//
//  items.swift
//  NewsApp
//
//  Created by Alperen Kavuk on 9.04.2023.
//

import Foundation
class MyItem {
    var NewsTitle: String
    var postedBy: String
    var date: String
    var newsAuthor: String
    var documantId: String
    var urlnews: String
    
    init(newsTitle: String, postedBy: String, date: String, newsAuthor: String, documantId: String, urlnews: String) {
        self.NewsTitle = newsTitle
        self.postedBy = postedBy
        self.date = date
        self.newsAuthor = newsAuthor
        self.documantId = documantId
        self.urlnews = urlnews
    }
}
