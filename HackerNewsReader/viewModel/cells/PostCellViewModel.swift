//
//  PostCellViewModel.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/17/20.
//

import Foundation

class PostCellViewModel {
    var post: Post
    var title: String? {
        return post.storyTitle ?? post.title
    }

    var detail: String {
        return post.author
    }
    var url: URL? {
        if let stringURL = post.storyURL ?? post.url {
            return URL(string: stringURL)
        } else {
            return nil
        }
    }
    init(post: Post) {
        self.post = post
    }
}

