//
//  AppReducer.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/28.
//

import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
        authState: authReducer(state: state?.authState, action: action),
        repositories: repositoriesReducer(state: state?.repositories, action: action),
        bookmarks: bookmarksReducer(state: state?.bookmarks, action: action)
    )
}
