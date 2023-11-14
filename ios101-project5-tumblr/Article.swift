//
//  Post.swift
//  ios101-project5-tumbler
//

import Foundation

struct ArticleResponse: Decodable {
    let results: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
    let link: String
    let category: [String]
}
