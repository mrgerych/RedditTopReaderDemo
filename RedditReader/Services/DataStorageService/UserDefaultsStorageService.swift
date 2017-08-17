//
//  CacheUtils.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import Foundation

class UserDefaultsStorageService: DataStorageService {
    let storeKey = "posts"

    func retrievePostsFromStorage() -> [PostModel]? {
        if let data = UserDefaults.standard.data(forKey: storeKey),
           let postsList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [PostModel] {
            return postsList
        }
        return nil
    }

    func savePostsToStorage(_ posts: [PostModel]) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: posts)
        UserDefaults.standard.set(encodedData, forKey: storeKey)
        UserDefaults.standard.synchronize()
    }

}
