//
//  DataStorage.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import Foundation

protocol DataStorageService {

    func retrievePostsFromStorage() -> [PostModel]?

    func savePostsToStorage(_ posts: [PostModel])

}
