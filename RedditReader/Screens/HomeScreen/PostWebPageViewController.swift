//
//  FullImageViewController.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import UIKit

class PostWebPageViewController: WebPageViewController {}

extension PostWebPageViewController: PostModelPresenter {

    func presentDataForPost(_ post: PostModel) {
        guard let postWebPageUrlString = post.postUrl else {
            return
        }
        self.urlToLoad = URL(string: postWebPageUrlString)
    }

}
