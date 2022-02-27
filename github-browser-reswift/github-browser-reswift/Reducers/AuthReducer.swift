//
//  AuthReducer.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/28.
//

import Foundation
import ReSwift
import OctoKit

func authReducer(state: AuthState?, action: Action) -> AuthState {
    var state = state ?? defaultAuthState()
    
    switch action {
    case _ as ReSwiftInit:
        break
        
    case let action as SetOAuthURL:
        state.oAuthURL = action.oAuthURL
        
    case let action as UpdateLoggedInState:
        state.loggedInState = action.loggedInState
        
    default:
        break
    }
    
    return state
}

func defaultAuthState() -> AuthState {
    let config = OAuthConfiguration(
        token: githubClientId,
        secret: githubClientSecret,
        scopes: ["repo", "repo:org"]
    )
    
    if let authData = AuthService().authData() {
        return AuthState(
            oAuthConfig: config,
            oAuthURL: nil,
            loggedInState: .loggedIn(authData)
        )
    }
    else {
        return AuthState(
            oAuthConfig: config,
            oAuthURL: nil,
            loggedInState: .notLoggedIn
        )
    }
}
