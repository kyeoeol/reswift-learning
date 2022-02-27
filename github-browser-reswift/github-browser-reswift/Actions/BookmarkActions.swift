//
//  BookmarkActions.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/27.
//

import Foundation
import ReSwift
import ReSwiftRouter

struct CreateBookmark: Action {
    let route: [RouteElementIdentifier]
    let routeSpecificData: Any?
}
