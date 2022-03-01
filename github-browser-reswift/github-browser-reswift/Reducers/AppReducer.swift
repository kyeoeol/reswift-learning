//
//  AppReducer.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/01.
//

import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
        authenticationState: authenticationReducer(action: action, state: state?.authenticationState)
    )
}
