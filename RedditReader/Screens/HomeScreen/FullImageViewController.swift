//
//  FullImageViewController.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController {
    
    @IBOutlet weak var fullImageView: UIWebView!

    var postPageRequest: URLRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        if let request = postPageRequest {
            self.fullImageView.loadRequest(request)
        }
    }
    
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

extension FullImageViewController: PostModelPresenter{
    func fillWithModel(_ postModel: PostModel) {
        if let stringUrl = postModel.imageUrl, let url = URL(string: stringUrl) {
            self.postPageRequest = URLRequest(url: url)
        }
    }
}
