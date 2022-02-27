//
//  AuthenticationActions.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/27.
//

import ReSwift
import ReSwiftRouter
import ReSwiftThunk
import OctoKit

let authUser = Thunk<AppState> { dispatch, getState in
    guard let config = getState()?.authState.oAuthConfig else { return }
    
    if let url = config.authenticate() {
        dispatch(SetOAuthURL(oAuthURL: url))
        dispatch(SetRouteAction([loginRoute, oAuthRoute]))
    }
}

func handleOpenURL(url: URL) -> Thunk<AppState> {
    return Thunk<AppState> { dispatch, getState in
        guard let config = getState()?.authState.oAuthConfig else { return }
        
        config.handleOpenURL(openURL: url) { (config: TokenConfiguration) in
            DispatchQueue.main.async {
                AuthService().saveAuthData(config)
                
                dispatch(UpdateLoggedInState(loggedInState: .loggedIn(config)))
                /// 메인 뷰 Route로 전환
                dispatch(ReSwiftRouter.SetRouteAction([mainViewRoute]))
            }
        }
    }
}

struct SetOAuthURL: Action {
    let oAuthURL: URL
}

struct UpdateLoggedInState: Action {
    let loggedInState: LoggedInState
}
