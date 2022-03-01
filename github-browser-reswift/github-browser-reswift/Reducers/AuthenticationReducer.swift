//
//  AuthenticationReducer.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/01.
//

import ReSwift
import ReSwiftRouter
import ReSwiftThunk
import OctoKit

func authenticationReducer(action: Action, state: AuthenticationState?) -> AuthenticationState {
    var state = state ?? configDefaultAuthenticationState()
    
    switch action {
    case let action as SetOAuthURL:
        state.oAuthURL = action.oAuthUrl
        
    case let action as UpdateLoggedInState:
        state.loggedInState = action.loggedInState
        
    default:
        break
    }
    
    return state
}

func configDefaultAuthenticationState() -> AuthenticationState {
    let config = OAuthConfiguration(
        token: githubClientId,
        secret: githubClientSecret,
        scopes: ["repo", "repo:org"]
    )
    
    if let authData = AuthenticationService().authenticationData() {
        return AuthenticationState(
            oAuthConfig: config,
            oAuthURL: nil,
            loggedInState: .loggedIn(authData)
        )
    }
    else {
        return AuthenticationState(
            oAuthConfig: config,
            oAuthURL: nil,
            loggedInState: .notLoggedIn
        )
    }
}
