//
//  GitHubRepositoriesActions.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/06.
//

import Foundation
import ReSwift
import OctoKit
import RequestKit

struct SetRepositories: Action {
    let repositories: Response<[Repository]>
}
