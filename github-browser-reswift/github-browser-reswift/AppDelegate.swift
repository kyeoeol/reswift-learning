//
//  AppDelegate.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/27.
//

import UIKit
import ReSwift
import ReSwiftRouter
import ReSwiftThunk

let loggingMiddleware: Middleware<Any> = { dispatch, getState in
    return { next in
        return { action in
            /// perform middleware logic
            print("--->[loggingMiddleware]:", action)

            /// call next middleware
            return next(action)
        }
    }
}
let thunkMiddleware: Middleware<AppState> = createThunkMiddleware()

let mainStore = Store<AppState>(
    reducer: appReducer,
    state: nil,
    middleware: [loggingMiddleware, thunkMiddleware]
)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router<AppState>!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        /// UIKit을 만족하도록 더미 VC 설정한다.
        /// Router는 비동기 호출을 통해 올바른 VC를 설정한다.
        /// 이 작업을 하지 않으면 crash가 발생한다.
        window?.rootViewController = UIViewController()
        
        let rootRoutable = RootRoutable(window: window!)
        router = Router(store: mainStore, rootRoutable: rootRoutable) { state in
            state.select {
                $0.navigationState
            }
        }
        
        if case .loggedIn(_) = mainStore.state.authenticationState.loggedInState {
            mainStore.dispatch(
                ReSwiftRouter.SetRouteAction([MainRoute])
            )
        }
        else {
            mainStore.dispatch(
                ReSwiftRouter.SetRouteAction([LoginRoute])
            )
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

