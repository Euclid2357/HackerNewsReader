//
//  PersistenceService.swift
//  HackerNewsReader
//
//  Created by Claudio on 10/18/20.
//

import Foundation
protocol PersistenceService {
    func markAsRemoved(post: Post)
}
