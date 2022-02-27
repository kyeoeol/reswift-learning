//
//  AppDelegate.swift
//  tabbar-navigation-reswift-router
//
//  Created by haanwave on 2022/02/27.
//

import UIKit
import ReSwift
import ReSwiftRouter

let mainStore = Store<AppState>(
    reducer: AppReducer,
    state: AppState(),
    middleware: [loggingMiddleware]
)

let loggingMiddleware: Middleware<Any> = { dispatch, getState in
    return { next in
        return { action in
            // perform middleware logic
            print(action)

            // call next middleware
            return next(action)
        }
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router<AppState>!
    var rootViewController: Routable!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// set router
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: HomeViewController.identifier)
        let userViewController = storyboard.instantiateViewController(withIdentifier: UserViewController.identifier)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            homeViewController,
            userViewController
        ]
        tabBarController.delegate = self
        rootViewController = tabBarController
        
        router = Router(store: mainStore, rootRoutable: RootRoutable(routable: rootViewController)) { state in
            state.select { $0.navigationState }
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

// MARK: - UITabBarControllerDelegate
extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController is HomeViewController {
            mainStore.dispatch(
                SetRouteAction([
                    "TabBarController",
                    HomeViewController.identifier
                ])
            )
        }
        else if viewController is UserViewController {
            mainStore.dispatch(
                SetRouteAction([
                    "TabBarController",
                    UserViewController.identifier
                ])
            )
        }
        
        return false
    }
}

// MARK: - RootRoutable
class RootRoutable: Routable {
    var routable: Routable
    
    init(routable: Routable) {
        self.routable = routable
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                          animated: Bool,
                          completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        completionHandler()
        return self.routable
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                         animated: Bool,
                         completionHandler: @escaping RoutingCompletionHandler) {
        completionHandler()
    }
}
