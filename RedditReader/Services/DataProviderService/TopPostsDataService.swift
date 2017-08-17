//
//  TopPostsDataService.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import Foundation

class TopPostsDataService: DataProviderService {
    let networkDataService: DataProviderService
    let cacheDataService: DataProviderService

    var showedInitialCache = false

    init(networkDataService: DataProviderService, cacheDataService: DataProviderService) {
        self.networkDataService = networkDataService
        self.cacheDataService = cacheDataService
    }

    func getTopPosts(limit: Int, completion: @escaping (([PostModel]?) -> Void)) {
        guard showedInitialCache else {
            showedInitialCache = true
            cacheDataService.getTopPosts(limit: limit, completion: completion)
            networkDataService.getTopPosts(limit: limit, completion: completion)
            return
        }

        if NetworkUtils.isInternetAvailable() {
            networkDataService.getTopPosts(limit: limit, completion: completion)
        } else {
            cacheDataService.getTopPosts(limit: limit, completion: completion)
        }
    }

}
