//
//  ViewController.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import UIKit

class PostListViewController: UITableViewController {
    let reuseIdentifier = "PostCell"
    let showPostSegueName = "showPostWebPage"
    let showPostImageSegueName = "showFullImage"

    let rowOffsetToLoadNextChunk = 2

    var datasourceArray: [PostModel]?
    var presentingPostModel: PostModel?
    var postsRefreshControl: UIRefreshControl!
    var dataService: DataProviderService!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareDataService()
        prepareTableView()
        updateData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    func prepareDataService() {
        let userDefaultsStorage = UserDefaultsStorageService()
        let networkDataService = NetworkDataService(storageService: userDefaultsStorage)
        let cacheDataService = CacheDataService(dataStorage: userDefaultsStorage)

        dataService = GeneralDataService(networkDataService: networkDataService,
                cacheDataService: cacheDataService)
    }

    func prepareTableView() {
        self.tableView.register(UINib(nibName: RedditPostTableViewCell.className, bundle: nil),
                forCellReuseIdentifier: reuseIdentifier)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 82
        postsRefreshControl = UIRefreshControl()
        postsRefreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        self.refreshControl = postsRefreshControl
    }

    @objc func updateData() {
        dataService?.getTopPosts(limit: 50) { [unowned self] posts in
            self.datasourceArray = posts
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let postModelPresenter = segue.destination as? PostModelPresenter,
              let presentingPostModel = presentingPostModel else {
            return
        }

        postModelPresenter.presentDataForPost(presentingPostModel)
    }

}

extension PostListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasourceArray?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! RedditPostTableViewCell
        cell.delegate = self
        cell.fillWithModel(self.datasourceArray![indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentingPostModel = self.datasourceArray![indexPath.row]
        self.performSegue(withIdentifier: showPostSegueName, sender: self)
    }

    // Basic implementation for pagination. Just demo.
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let dataCount = self.datasourceArray!.count
        let visibleCellsCount = tableView.visibleCells.count

        guard visibleCellsCount < dataCount && indexPath.row == dataCount - rowOffsetToLoadNextChunk else {
            return
        }

        let userDefaultsStorage = UserDefaultsStorageService()
        let cacheDataService = CacheDataService(dataStorage: userDefaultsStorage)

        cacheDataService.getTopPosts(limit: 50, completion: { newPosts in
            self.datasourceArray! += newPosts!
            let indexPaths = (dataCount - newPosts!.count..<dataCount)
                    .map {
                IndexPath(row: $0, section: 0)
            }
            tableView.beginUpdates()
            tableView.insertRows(at: indexPaths, with: .automatic)
            tableView.endUpdates()
        })
    }

}

extension PostListViewController: RedditPostCellDelegate {

    func showFullPhotoForPost(_ post: PostModel) {
        presentingPostModel = post
        self.performSegue(withIdentifier: showPostImageSegueName, sender: self)
    }

}
