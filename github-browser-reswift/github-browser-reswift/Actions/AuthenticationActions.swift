//
//  AuthenticationActions.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/01.
//

import ReSwift
import ReSwiftRouter
import ReSwiftThunk
import OctoKit

let authenticationUser = Thunk<AppState> { dispatch, state in
    guard let config = state()?.authenticationState.oAuthConfig else {
        print("--->[authenticationUser] no config data")
        return
    }
    
    if let oAuthUrl = config.authenticate() {
        dispatch(
            SetOAuthURL(oAuthUrl: oAuthUrl)
        )
        dispatch(
            SetRouteAction([
                LoginRoute,
                OAuthRoute
            ])
        )
    }
    else {
        print("--->[authenticationUser] no oAuthUrl")
    }
}

struct SetOAuthURL: Action {
    let oAuthUrl: URL
}

struct UpdateLoggedInState: Action {
    let loggedInState: LoggedInState
}

