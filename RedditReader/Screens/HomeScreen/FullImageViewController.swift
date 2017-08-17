//
//  FullImageViewController.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import UIKit

// Nothing to save while using webview to show images
class FullImageViewController: WebPageViewController {}

extension FullImageViewController: PostModelPresenter {

    func presentDataForPost(_ post: PostModel) {
        guard let postImageUrlString = post.imageUrl else {
            return
        }
        self.urlToLoad = URL(string: postImageUrlString)
    }

}
