//
//  NetworkDataService.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import Foundation

class NetworkDataService: DataProviderService {
    let urlString = "http://reddit.com/top.json"
    let storageService: DataStorageService

    init(storageService: DataStorageService) {
        self.storageService = storageService
    }

    func getTopPosts(limit: Int, completion: @escaping (([PostModel]?) -> Void)) {
        let url = URL(string: "\(urlString)?limit=\(limit)")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let posts = DataUtils.postsFromListData(data) else {
                completion(nil)
                return
            }
            self.storageService.savePostsToStorage(posts)
            completion(posts)
        })
        task.resume()
    }

}
