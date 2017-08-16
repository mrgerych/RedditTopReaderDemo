//
//  ClassUtils.swift
//  RedditReader
//
//  Created by ios developer on 8/16/17.
//  Copyright © 2017 ios developer. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }
}
