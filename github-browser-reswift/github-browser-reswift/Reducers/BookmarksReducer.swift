//
//  BookmarksReducer.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/28.
//

import Foundation
import ReSwift
import ReSwiftRouter

func bookmarksReducer(state: [Bookmark]?, action: Action) -> [Bookmark] {
    var state = state ?? []

    switch action {
    case let action as CreateBookmark:
        let bookmark = (route: action.route, routeSpecificData: action.routeSpecificData)
        state.append(bookmark)
        return state
        
    default:
        return state
    }
}
