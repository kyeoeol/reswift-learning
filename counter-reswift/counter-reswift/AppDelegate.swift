//
//  AppDelegate.swift
//  counter-reswift
//
//  Created by haanwave on 2022/02/26.
//

import UIKit
import ReSwift

/// 앱의 state를 관리하는 전역 store
let mainStore = Store<AppState>(
    reducer: counterReducer,
    state: nil
)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

