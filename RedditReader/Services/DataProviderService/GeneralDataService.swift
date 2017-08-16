//
//  GeneralDataService.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import Foundation

class GeneralDataService: DataProviderService {
    let networkDataService: DataProviderService
    let cacheDataService: DataProviderService

    var initiallyLoadedFromCache = false

    init(networkDataService: DataProviderService, cacheDataService: DataProviderService) {
        self.networkDataService = networkDataService
        self.cacheDataService = cacheDataService
    }

    func getTopPosts(limit: Int, completion: @escaping (([PostModel]?) -> Void)) {
        guard initiallyLoadedFromCache else {
            initiallyLoadedFromCache = true
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

