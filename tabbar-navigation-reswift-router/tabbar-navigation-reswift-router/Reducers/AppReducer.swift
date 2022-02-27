//
//  AppReducer.swift
//  navigation-reswift-router
//
//  Created by haanwave on 2022/02/27.
//

import Foundation
import ReSwift
import ReSwiftRouter

func AppReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        navigationState: NavigationReducer.handleAction(action, state: state?.navigationState)
    )
}
