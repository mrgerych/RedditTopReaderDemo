//
//  WebPageViewController.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import UIKit

class WebPageViewController: UIViewController {

    private var postWebView: UIWebView!
    var urlToLoad: URL?
    var wasViewLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        prepareWebView()
        if let urlToLoad = urlToLoad {
            self.postWebView.loadRequest(URLRequest(url: urlToLoad))
        }
    }

    func prepareWebView() {
        postWebView = UIWebView()
        postWebView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postWebView)
    }
    
    override func viewWillLayoutSubviews() {
        if(!wasViewLoaded){
            wasViewLoaded = true
            
            let viewsDict: [String : Any] = ["postWebView" : postWebView]
            
            let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[postWebView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
            let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[postWebView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDict)
            view.addConstraints(horizontalConstraints)
            view.addConstraints(verticalConstraints)
        }
    }
}

