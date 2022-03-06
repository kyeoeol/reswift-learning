//
//  AppState.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/01.
//

import ReSwift
import ReSwiftRouter
import OctoKit
import RequestKit

struct AppState: StateType, HasNavigationState {
    var navigationState: NavigationState
    var authenticationState: AuthenticationState
    var repositories: Response<[Repository]>?
}
