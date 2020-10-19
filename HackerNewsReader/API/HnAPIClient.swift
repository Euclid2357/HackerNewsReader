//
//  HnAPIClient.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/17/20.
//

import Foundation

class HnAPIClient: HackerNewsService {
    static let shared = HnAPIClient()
    let hnEndpoint = "http://hn.algolia.com/api/v1/search_by_date?query=ios"
    
    func fetchPosts(complete: @escaping (Bool, [Post], Error?) -> ()) {
        if let postsURL = URL(string: hnEndpoint){
                let dataTask = URLSession.shared.dataTask(with: postsURL, completionHandler: { (data, response, error) in
                    if let responseData = data {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let results = try jsonDecoder.decode(HNResults.self, from: responseData)
                            FilePersistence.shared.saveCache(jsonData: responseData)
                            complete(true, results.posts, nil)
                        } catch  {
                            print(error.localizedDescription)
                        }
                    }
            })
            dataTask.resume()
        }
    }
}
