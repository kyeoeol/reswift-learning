//
//  GitHubAPIReducers.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/06.
//

import ReSwift
import OctoKit
import RequestKit

func repositoriesReducer(action: Action, state: Response<[Repository]>?) -> Response<[Repository]>? {
    switch action {
    case let action as SetRepositories:
        return action.repositories
        
    default:
        return nil
    }
}
