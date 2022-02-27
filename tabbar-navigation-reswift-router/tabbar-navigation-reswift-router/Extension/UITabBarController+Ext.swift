//
//  UITabBarController+Ext.swift
//  navigation-reswift-router
//
//  Created by haanwave on 2022/02/27.
//

import UIKit
import ReSwift
import ReSwiftRouter

extension UITabBarController: Routable {
    public func changeRouteSegment(_ from: RouteElementIdentifier,
                            to: RouteElementIdentifier,
                            animated: Bool,
                            completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        if to == HomeViewController.identifier {
            selectedIndex = 0
            completionHandler()
            return viewControllers![0] as! Routable
        }
        else if to == UserViewController.identifier {
            selectedIndex = 1
            completionHandler()
            return viewControllers![1] as! Routable
        }
        
        abort()
    }
    
    public func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                                 animated: Bool,
                                 completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        if routeElementIdentifier == HomeViewController.identifier {
            selectedIndex = 0
            completionHandler()
            return viewControllers![0] as! Routable
        }
        else if routeElementIdentifier == UserViewController.identifier {
            selectedIndex = 1
            completionHandler()
            return viewControllers![1] as! Routable
        }
        
        abort()
    }
    
    public func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                                animated: Bool,
                                completionHandler: @escaping RoutingCompletionHandler) {
        
        completionHandler()
    }
}
