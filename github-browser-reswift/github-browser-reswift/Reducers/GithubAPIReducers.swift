//
//  GithubAPIReducers.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/28.
//

import ReSwift
import OctoKit
import RequestKit

func repositoriesReducer(state: Response<[Repository]>?, action: Action) -> Response<[Repository]>? {
    switch action {
    case let action as SetRepositories:
        return action.repositories
        
    default:
        return nil
    }
}
