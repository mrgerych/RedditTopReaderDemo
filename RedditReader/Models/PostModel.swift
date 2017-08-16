//
//  PostModel.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import Foundation

class PostModel: NSObject, NSCoding {
    let postId: String?
    let title: String?
    let author: String?
    let thumbnail: String?
    let postUrl: String?
    let imageUrl: String?
    let date: Date?
    let commentsCount: Int?

    var dateString: String? {
        if let date = date {
            return DateUtils.timeAgoSinceDate(date)
        } else {
            return nil
        }
    }

    required init(sourceDictionary: [String: Any]) {
        self.postId = sourceDictionary["id"] as? String
        self.title = sourceDictionary["title"] as? String
        self.author = sourceDictionary["author"] as? String
        self.thumbnail = sourceDictionary["thumbnail"] as? String
        self.imageUrl = sourceDictionary["url"] as? String
        self.commentsCount = sourceDictionary["num_comments"] as? Int

        if let permalink = sourceDictionary["permalink"] as? String {
            self.postUrl = "https://reddit.com\(permalink)"
        } else {
            self.postUrl = nil
        }

        if let milliseconds = sourceDictionary["created_utc"] as? Int {
            self.date = Date(timeIntervalSince1970: TimeInterval(milliseconds))
        } else {
            self.date = nil
        }
    }

    required init(coder decoder: NSCoder) {
        postId = decoder.decodeObject(forKey: "postId") as? String
        title = decoder.decodeObject(forKey: "title") as? String
        author = decoder.decodeObject(forKey: "author") as? String
        thumbnail = decoder.decodeObject(forKey: "thumbnail") as? String
        commentsCount = decoder.decodeObject(forKey: "commentsCount") as? Int
        postUrl = decoder.decodeObject(forKey: "postUrl") as? String
        imageUrl = decoder.decodeObject(forKey: "imageUrl") as? String
        if let timeIntervalSince1970 = decoder.decodeObject(forKey: "created_utc") as? Double {
            date = Date(timeIntervalSince1970: timeIntervalSince1970)
        } else {
            date = nil
        }
    }

    func encode(with coder: NSCoder) {
        coder.encode(postId, forKey: "postId")
        coder.encode(title, forKey: "title")
        coder.encode(author, forKey: "author")
        coder.encode(thumbnail, forKey: "thumbnail")
        coder.encode(imageUrl, forKey: "imageUrl")
        coder.encode(commentsCount, forKey: "commentsCount")
        coder.encode(postUrl, forKey: "postUrl")
        if let timeIntervalSince1970 = date?.timeIntervalSince1970 {
            coder.encode(timeIntervalSince1970, forKey: "created_utc")
        }
    }
}
