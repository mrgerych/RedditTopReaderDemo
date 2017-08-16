//
//  DataUtils.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import Foundation

class DataUtils {
    static func postsFromListData(_ data: Data?) -> [PostModel]? {
        do {
            if let data = data,
               let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
               let responseData = json["data"] as? [String: Any],
               let postsArray = responseData["children"] as? [[String: Any]] {
                return postsArray.map({ (postData) -> PostModel in
                    return PostModel(sourceDictionary: postData["data"] as! [String: Any])
                })
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
