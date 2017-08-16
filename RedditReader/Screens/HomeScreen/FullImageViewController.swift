//
//  FullImageViewController.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import UIKit

class FullImageViewController: WebPageViewController {
        // Nothing to save while using webview to show images
    func storeImageToGallery(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let _ = error {
            print("error")
        } else {
            print("success")
        }
    }
}

extension FullImageViewController: PostModelPresenter {
    func presentDataForPost(_ post: PostModel) {
        guard let postImageUrlString = post.imageUrl else { return }
        self.urlToLoad = URL(string: postImageUrlString)
    }
}