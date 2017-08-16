//
//  PostWebPageViewController.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import UIKit

class PostWebPageViewController: UIViewController {

    @IBOutlet weak var postWebView: UIWebView!
    var postPageRequest: URLRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        if let request = postPageRequest {
            self.postWebView.loadRequest(request)
        }
    }
}

extension PostWebPageViewController: PostModelPresenter{
    func fillWithModel(_ postModel: PostModel) {
        if let stringUrl = postModel.postUrl, let url = URL(string: stringUrl) {
                self.postPageRequest = URLRequest(url: url)
        }
    }
}
