//
//  WikipediaModel.swift
//  Bucket List
//
//  Created by Анна Перехрест  on 2023/10/04.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
    static func <(lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    static let example = Page(pageid: 1, title: "Title", terms: ["description": ["description"]])
}

enum LoadingState {
    case loading, loaded, failed
}
