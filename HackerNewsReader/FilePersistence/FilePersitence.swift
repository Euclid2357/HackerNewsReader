//
//  FilePersitence.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/18/20.
//

import Foundation
class FilePersistence: PersistenceService {
    static var shared = FilePersistence()
    
    private var removedItemsURL: URL {
        let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docsUrl.appendingPathExtension("removed")
    }
    var removedList: [String] {
        if let array = NSArray(contentsOf: removedItemsURL) {
            return array as? [String] ?? [String]()
        }
        return [String]()
    }

    func markAsRemoved(post: Post) {
        var removedIds = [String](removedList)
        removedIds.append(post.objectID)
        try? (removedIds as NSArray) .write(to: removedItemsURL)
    }
    
    
}
