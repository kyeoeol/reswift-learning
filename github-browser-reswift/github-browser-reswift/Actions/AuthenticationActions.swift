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
        print("--->[AuthenticationActions:authenticationUser] no config data")
        return
    }
    
    if let oAuthUrl = config.authenticate() {
        print("--->[AuthenticationActions:authenticationUser] oAuthUrl:", oAuthUrl)
        dispatch(
            SetOAuthURL(oAuthUrl: oAuthUrl)
        )
        dispatch(
            SetRouteAction([
                MainRoute,
                LoginRoute,
                OAuthRoute
            ])
        )
    }
    else {
        print("--->[AuthenticationActions:authenticationUser] no oAuthUrl")
    }
}

func handleOpenURL(url: URL) -> Thunk<AppState> {
    return Thunk<AppState> { dispatch, state in
        guard let config = state()?.authenticationState.oAuthConfig else {
            print("--->[AuthenticationActions:handleOpenURL] no config data")
            return
        }
        
        config.handleOpenURL(openUrl: url) { tokenConfig in
            DispatchQueue.main.async {
                AuthenticationService().saveAuthenticationData(with: tokenConfig)
                
                dispatch(
                    UpdateLoggedInState(loggedInState: .loggedIn(tokenConfig))
                )
                /// main view로 전환
                dispatch(
                    SetRouteAction([MainRoute])
                )
            }
        }
    }
}

struct SetOAuthURL: Action {
    let oAuthUrl: URL
}

struct UpdateLoggedInState: Action {
    let loggedInState: LoggedInState
}

