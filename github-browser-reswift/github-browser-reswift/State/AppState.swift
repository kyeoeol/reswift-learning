//
//  AppState.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/27.
//

import ReSwift
import ReSwiftRouter
import OctoKit
import RequestKit

struct AppState: StateType, HasNavigationState {
    var navigationState: NavigationState
    var authState: AuthState
    var repositories: Response<[Repository]>?
    var bookmarks: [Bookmark]
}

typealias Bookmark = (route: [RouteElementIdentifier], routeSpecificData: Any?)
