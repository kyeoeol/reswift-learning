//
//  AppState.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/01.
//

import ReSwift
import ReSwiftRouter

struct AppState: StateType, HasNavigationState {
    var navigationState: NavigationState
    var authenticationState: AuthenticationState
}
