//
//  HackerNewsService.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/17/20.
//

import Foundation

protocol HackerNewsService {
    func fetchPosts( complete: @escaping ( _ success: Bool, _ posts: [Post], _ error: Error? )->() )
}
