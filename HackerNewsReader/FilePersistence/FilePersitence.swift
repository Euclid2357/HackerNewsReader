//
//  FilePersitence.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/18/20.
//

import Foundation
class FilePersistence: PersistenceService {
    static var shared = FilePersistence()
    
    private var offlineCacheURL: URL {
        let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docsUrl.appendingPathComponent("jsonCache")
    }

    func saveCache(jsonData: Data) {
        try? jsonData.write(to: offlineCacheURL, options: .atomic)
    }
    func loadCache() -> Data? {
        let answer = try? Data(contentsOf: offlineCacheURL, options: [])
        return answer
    }
    
    
}
