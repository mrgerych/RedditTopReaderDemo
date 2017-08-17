//
//  CacheDataService.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import Foundation

class CacheDataService: DataProviderService {
    let dataStorage: DataStorageService

    init(dataStorage: DataStorageService) {
        self.dataStorage = dataStorage
    }

    func getTopPosts(limit: Int, completion: @escaping (([PostModel]?) -> Void)) {
        guard let posts = dataStorage.retrievePostsFromStorage() else {
            completion(nil)
            return
        }
        if posts.count > limit {
            completion(Array(posts[0...limit]))
        } else {
            completion(posts)
        }
    }

}
