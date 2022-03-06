//
//  Routes.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/01.
//

import ReSwiftRouter
import SafariServices

let storyboard = UIStoryboard(name: "Main", bundle: nil)

let LoginRoute = "LoginViewController"
let OAuthRoute = "OAuth"
let MainRoute = "MainViewController"

class RootRoutable: Routable {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func setMainRoutable() -> Routable {
        let mainVC = storyboard.instantiateViewController(withIdentifier: MainRoute)
        window.rootViewController = mainVC
        
        return MainRoutable(viewController: window.rootViewController!)
    }
    
    func changeRouteSegment(_ from: RouteElementIdentifier,
                            to: RouteElementIdentifier,
                            animated: Bool,
                            completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        print("--->[RootRoutable:changeRouteSegment] change, to:", to)
        
        if to == MainRoute {
            completionHandler()
            return setMainRoutable()
        }
        else {
            fatalError("--->[RootRoutable] Route not supported!")
        }
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                          animated: Bool,
                          completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        print("--->[RootRoutable:pushRouteSegment] push, routeElementIdentifier:", routeElementIdentifier)
        
        if routeElementIdentifier == MainRoute {
            completionHandler()
            return setMainRoutable()
        }
        else {
            fatalError("--->[RootRoutable] Route not supported!")
        }
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                         animated: Bool,
                         completionHandler: @escaping RoutingCompletionHandler) {
        print("--->[RootRoutable:popRouteSegment] pop, routeElementIdentifier:", routeElementIdentifier)
        
        /// 이것은 기술적으로 호출되지 않아야 한다 -> Router의 버그
        completionHandler()
    }
}

class MainRoutable: Routable {
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func setLoginRoutable() -> Routable {
        let loginVC = storyboard.instantiateViewController(withIdentifier: LoginRoute) as! LoginViewController
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        viewController.present(loginVC, animated: true)
        
        return LoginRoutable(loginVC)
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                          animated: Bool,
                          completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        if routeElementIdentifier == LoginRoute {
            completionHandler()
            return setLoginRoutable()
        }
        else {
            fatalError("--->[MainRoutable] Route not supported!")
        }
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                         animated: Bool,
                         completionHandler: @escaping RoutingCompletionHandler) {
        print("--->[MainRoutable:popRouteSegment] pop, routeElementIdentifier:", routeElementIdentifier)
        
        if routeElementIdentifier == LoginRoute {
            viewController.dismiss(animated: true, completion: completionHandler)
        }
    }
}

class LoginRoutable: Routable {
    let viewController: LoginViewController
    
    init(_ viewController: LoginViewController) {
        self.viewController = viewController
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                          animated: Bool,
                          completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        print("--->[LoginRoutable:pushRouteSegment] push, routeElementIdentifier:", routeElementIdentifier)
        
        if routeElementIdentifier == OAuthRoute {
            if let oAuthUrl = mainStore.state.authenticationState.oAuthURL {
                let safatiViewController = SFSafariViewController(url: oAuthUrl)
                safatiViewController.modalPresentationStyle = .overFullScreen
                safatiViewController.delegate = viewController
                viewController.present(safatiViewController,
                                       animated: true,
                                       completion: completionHandler)
                return OAuthRoutable()
            }
            else {
                print("--->[LoginRoutable:pushRouteSegment] no oAuthUrl data")
            }
        }
        
        fatalError("--->[LoginRoutable] Router could not proceed.")
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                         animated: Bool,
                         completionHandler: @escaping RoutingCompletionHandler) {
        print("--->[LoginRoutable:popRouteSegment] pop, routeElementIdentifier:", routeElementIdentifier)
        
        if routeElementIdentifier == OAuthRoute {
            viewController.dismiss(animated: true, completion: completionHandler)
        }
    }
}

class OAuthRoutable: Routable {}
