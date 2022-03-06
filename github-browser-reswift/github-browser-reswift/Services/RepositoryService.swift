//
//  RepositoryService.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/06.
//

import Foundation
import OctoKit
import ReSwift
import ReSwiftThunk

let fetchGitHubRepositories = Thunk<AppState> { dispatch, state in
    guard case let .loggedIn(tokenConfig)? = state()?.authenticationState.loggedInState else {
        print("--->[fetchGitHubRepositories] no tokenData")
        return
    }

    _ = Octokit(tokenConfig).repositories { response in
        DispatchQueue.main.async {
            dispatch(
                SetRepositories(repositories: response)
            )
        }
    }
}
