//
//  CacheClient.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/18/20.
//

import Foundation
class CacheClient: HackerNewsService {
    static let shared = CacheClient()
    func fetchPosts(complete: @escaping (Bool, [Post], Error?) -> ()) {
        if let data = FilePersistence.shared.loadCache() {
            let jsonDecoder = JSONDecoder()
            do {
                let results = try jsonDecoder.decode(HNResults.self, from: data)
                complete(true, results.posts, nil)
            } catch  {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
