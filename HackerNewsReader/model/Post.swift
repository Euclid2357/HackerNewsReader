//
//  Post.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/16/20.
//

import Foundation
struct Post: Codable {
    var createdAt: String
    var title: String?
    var url: String?
    var author: String
    var storyTitle: String?
    var storyURL: String?
    var createdAtI: Int
    var objectID: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case title, url, author
        case storyTitle = "story_title"
        case storyURL = "story_url"
        case createdAtI = "created_at_i"
        case objectID
    }
}

struct HNResults: Codable {
    var posts: [Post]
}
