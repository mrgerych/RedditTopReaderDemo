//
//  RedditPostTableViewCell.swift
//  RedditReader
//
//  Created by ios developer on 8/15/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import UIKit

class RedditPostTableViewCell: UITableViewCell {
    weak var delegate: RedditPostCellDelegate?

    var postModel: PostModel!

    @IBOutlet weak var thumbButton: UIButton!

    @IBOutlet weak var postTitleLabel: UILabel!

    @IBOutlet weak var postAuthorLabel: UILabel!

    @IBOutlet weak var postTimeLabel: UILabel!

    @IBOutlet weak var commetsCountLabel: UILabel!

    var thumbDownloadTask: URLSessionDataTask?

    func fillWithModel(_ postModel: PostModel) {
        self.postModel = postModel
        postTitleLabel.text = postModel.title
        postAuthorLabel.text = postModel.author
        commetsCountLabel.text = "\(postModel.commentsCount ?? 0) comments"
        postTimeLabel.text = postModel.dateString

        guard
                let thumbString = postModel.thumbnail, NetworkUtils.verifyUrl(urlString: thumbString),
                let thumbUrl = URL(string: thumbString) else {
            thumbButton.setImage(#imageLiteral(resourceName:"no-image"), for: .normal)
            return
        }
        thumbDownloadTask = URLSession.shared.dataTask(with: thumbUrl) { data, response, error in
            guard let data = data, error == nil else {
                return
            }

            DispatchQueue.main.async {
                self.thumbButton.setImage(UIImage(data: data), for: .normal)
            }
        }

        thumbDownloadTask?.resume()
    }

    @IBAction func showFullPhoto(_ sender: Any) {
        delegate?.showFullPhotoForPost(postModel)
    }

    override func prepareForReuse() {
        thumbDownloadTask?.cancel()
    }

}
