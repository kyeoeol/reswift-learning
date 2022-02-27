//
//  AppState.swift
//  navigation-reswift-router
//
//  Created by haanwave on 2022/02/27.
//

import Foundation
import ReSwift
import ReSwiftRouter

struct AppState: StateType, HasNavigationState {
    var navigationState = NavigationState()
}
