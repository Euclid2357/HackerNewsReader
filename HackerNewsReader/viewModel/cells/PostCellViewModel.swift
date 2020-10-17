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
        var answer = post.author
        let createdDate = Date(timeIntervalSince1970: TimeInterval(post.createdAtI))
        if let elapsedTimeString = self.elapsedTimeString(createdDate) {
            answer = "\(answer) - \(elapsedTimeString)"
        }
        return answer
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
    
    private func elapsedTimeString(_ date: Date) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 3
        formatter.allowsFractionalUnits = true
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        return formatter.string(from: date, to: Date())
    }
}

